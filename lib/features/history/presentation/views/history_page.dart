import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/history/data/model/history_scan_model.dart';
import 'package:graduation_project/features/history/logic/cubit/history_cubit.dart';
import 'package:graduation_project/features/history/logic/cubit/history_state.dart';
import 'package:graduation_project/features/result/presentation/widgets/severity_badge.dart';
import 'package:graduation_project/generated/l10n.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().fetchHistory();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<HistoryCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<HistoryCubit>().fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => Center(
              child:
                  CircularProgressIndicator(color: ColorsManager.primaryGreen),
            ),
            error: (message) => Center(
              child: Text(message, style: TextStyles.font14DarkGrey400Weight),
            ),
            success: (scans, hasMore) {
              return SafeArea(
                child: RefreshIndicator(
                  color: ColorsManager.primaryGreen,
                  onRefresh: _onRefresh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 48),
                            Expanded(
                              child: CustomAppText(
                                title: (context) => S.of(context).scanHistory,
                              ),
                            ),
                            PopupMenuButton(
                              icon: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [
                                    ColorsManager.primaryGreen,
                                    ColorsManager.listColor,
                                  ],
                                ).createShader(bounds),
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'clear_history',
                                  child: Text(S.of(context).clearHistory),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'clear_history') {
                                  context.read<HistoryCubit>().clearHistory();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      // Empty state or list
                      if (scans.isEmpty)
                        Expanded(
                          child: Center(
                            child: Text(
                              S.of(context).noScanYet,
                              style: TextStyles.font16darkGreen400Weight,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: scans.length + (hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < scans.length) {
                                return _HistoryCard(scan: scans[index]);
                              }
                              // Bottom loading indicator for pagination
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ColorsManager.primaryGreen,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final HistoryScanModel scan;
  const _HistoryCard({required this.scan});

  bool get isHealthy =>
      scan.healthStatus.toLowerCase() == S.current.healthy.toLowerCase();

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorsManager.primaryGreen,
            ColorsManager.listColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: EdgeInsets.all(12.w), // Responsive padding
        decoration: BoxDecoration(
          color: ColorsManager.lightGreen,
          borderRadius: BorderRadius.circular(15.r),
        ),

        child: Row(
          children: [
            ClipRRect(
              // Use responsive rounding for the internal image preview container
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                scan.cloudImage.secure_url,
                width: 72.w, // Responsive width matching layout proportions
                height: 72.h, // Responsive height matching layout proportions
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).tomatoPlant,
                        style: TextStyles.font16darkGreen600Weight,
                      ),
                      SeverityBadge(severity: scan.severity),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        isHealthy ? Icons.check_circle : Icons.error_rounded,
                        size: 14.w,
                        color: isHealthy
                            ? ColorsManager.primaryGreen
                            : ColorsManager.secondaryRed,
                      ),
                      SizedBox(width: 4.w),
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
                  SizedBox(height: 6.h),
                  Text(
                    _formatDate(scan.createdAt),
                    style: TextStyles.font14DarkGrey400Weight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
