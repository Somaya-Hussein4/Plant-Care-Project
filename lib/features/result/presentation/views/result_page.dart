import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/result/data/models/scan_result_model.dart';
import 'package:graduation_project/features/result/presentation/widgets/result_info.dart';
import 'package:graduation_project/features/result/presentation/widgets/severity_badge.dart';
import '../../logic/cubit/result_cubit.dart';
import '../../logic/cubit/result_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF4CAF50)),
          SizedBox(height: 16),
          Text(
            'Analyzing your plant...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF388E3C),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final ScanResultModel scan;
  const _SuccessView({required this.scan});

  bool get isHealthy => scan.healthStatus == 'healthy';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top bar
            Text(
              'Plant Disease Detection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),

            // image
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

            // plant name + severity badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tomato Plant',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isHealthy ? Icons.check_circle : Icons.error_rounded,
                          color: isHealthy
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE53935),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isHealthy ? 'Healthy' : (scan.disease ?? 'Unknown'),
                          style: TextStyle(
                            fontSize: 14,
                            color: isHealthy
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFE53935),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SeverityBadge(severity: scan.severity),
              ],
            ),
            const SizedBox(height: 16),

            // info card
            ResultInfoCard(description: scan.description),
            const SizedBox(height: 24),

            // button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                label: const Text(
                  'Scan Another Plant',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
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

class _ErrorView extends StatelessWidget {
  final String type;
  final String message;
  const _ErrorView({required this.type, required this.message});

  _ErrorConfig get config => switch (type) {
        'UNSUPPORTED_PLANT' => const _ErrorConfig(
            icon: Icons.local_florist_outlined,
            title: 'Tomato Plants Only',
            color: Color(0xFFFF8F00),
          ),
        'LOW_RESOLUTION' => const _ErrorConfig(
            icon: Icons.camera_outlined,
            title: 'Image Too Blurry',
            color: Color(0xFF1565C0),
          ),
        'LOW_CONFIDENCE' => const _ErrorConfig(
            icon: Icons.help_outline_rounded,
            title: "We're Not Sure",
            color: Color(0xFF6A1B9A),
          ),
        _ => const _ErrorConfig(
            icon: Icons.warning_amber_rounded,
            title: 'Something Went Wrong',
            color: Color(0xFFE53935),
          ),
      };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: config.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(config.icon, size: 64, color: config.color),
            ),
            const SizedBox(height: 24),
            Text(
              config.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF555555),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
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
