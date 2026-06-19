import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/result/data/models/scan_result_model.dart';
import 'package:graduation_project/features/result/presentation/widgets/result_info.dart';
import 'package:graduation_project/features/result/presentation/widgets/severity_badge.dart';
import 'package:graduation_project/generated/l10n.dart';

import '../../logic/cubit/result_cubit.dart';
import '../../logic/cubit/result_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const _LoadingView(),
            success: (scan) => _SuccessView(scan: scan),
            error: (type, message) => _ErrorView(type: type, message: message),
          );
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorsManager.primaryGreen),
          const SizedBox(height: 16),
          Text(
            S.of(context).analyzingYourPlant,
            style: TextStyles.font16darkGreen400Weight,
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final ScanResultModel scan;
  const _SuccessView({required this.scan});

  bool get isHealthy =>
      scan.healthStatus.toLowerCase() == S.current.healthy.toLowerCase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppText(title: (context) => S.of(context).pageTitle),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                scan.cloudImage.secureUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).tomatoPlant,
                      style: TextStyles.font16darkGreen600Weight,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isHealthy ? Icons.check_circle : Icons.error_rounded,
                          color: isHealthy
                              ? ColorsManager.primaryGreen
                              : ColorsManager.secondaryRed,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isHealthy
                              ? S.of(context).healthy
                              : (scan.disease ?? S.of(context).unknown),
                          style: TextStyles.font14Green400Weight.copyWith(
                            color: isHealthy
                                ? ColorsManager.primaryGreen
                                : ColorsManager.secondaryRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SeverityBadge(severity: scan.severity),
              ],
            ),
            const SizedBox(height: 25),
            ResultInfoCard(
              description: scan.description,
              isHealthy: isHealthy,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      ColorsManager.primaryGreen,
                      ColorsManager.secondaryGreen,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.qr_code_scanner,
                      color: ColorsManager.white),
                  label: Text(
                    S.of(context).scanAnotherPlant,
                    style: TextStyles.font16White400Weight,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _localizedMessage(BuildContext context, String type, String message) {
  return switch (type) {
    'UNKNOWN' => S.of(context).unknownError,
    'LOW_CONFIDENCE' => S.of(context).lowConfidenceError,
    'BLURRY_IMAGE' => S.of(context).lowResolutionError,
    'UNSUPPORTED_PLANT' => S.of(context).unsupportedPlantError,
    _ => message,
  };
}

class _ErrorView extends StatelessWidget {
  final String type;
  final String message;
  const _ErrorView({required this.type, required this.message});

  _ErrorConfig _config(BuildContext context) => switch (type) {
        'UNSUPPORTED_PLANT' => _ErrorConfig(
            icon: Icons.local_florist_outlined,
            title: S.of(context).unsupportedPlantError,
            color: ColorsManager.orange,
          ),
        'BLURRY_IMAGE' => _ErrorConfig(
            icon: Icons.camera_outlined,
            title: S.of(context).lowResolutionError,
            color: const Color(0xFF1565C0),
          ),
        'LOW_CONFIDENCE' => _ErrorConfig(
            icon: Icons.help_outline_rounded,
            title: S.of(context).lowConfidenceError,
            color: const Color(0xFF6A1B9A),
          ),
        _ => _ErrorConfig(
            icon: Icons.warning_amber_rounded,
            title: S.of(context).unknownError,
            color: ColorsManager.secondaryRed,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final cfg = _config(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cfg.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(cfg.icon, size: 64, color: cfg.color),
            ),
            const SizedBox(height: 24),
            Text(
              cfg.title,
              style: TextStyles.font22darkGreen400Weight,
            ),
            const SizedBox(height: 12),
            Text(
              _localizedMessage(context, type, message),
              textAlign: TextAlign.center,
              style: TextStyles.font14DarkGrey400Weight,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, color: ColorsManager.white),
                label: Text(
                  S.of(context).tryAgain,
                  style: TextStyles.font16White400Weight,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorConfig {
  final IconData icon;
  final String title;
  final Color color;
  const _ErrorConfig({
    required this.icon,
    required this.title,
    required this.color,
  });
}
