import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:graduation_project/features/history/data/model/history_scan_model.dart';
part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = _Initial;
  const factory HistoryState.loading() = _Loading;
  const factory HistoryState.success({
    required List<HistoryScanModel> scans,
    required bool hasMore,
  }) = _Success;
  const factory HistoryState.error(String message) = _Error;
}
