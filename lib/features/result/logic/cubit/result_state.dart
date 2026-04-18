import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/scan_result_model.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState with _$ResultState {
  const factory ResultState.initial() = _Initial;
  const factory ResultState.loading() = _Loading;
  const factory ResultState.success(ScanResultModel scan) = _Success;
  const factory ResultState.error(String type, String message) = _Error;
}
