import 'package:freezed_annotation/freezed_annotation.dart';

part 'care_guide_state.freezed.dart';

enum CareGuideTab { articles, videos }

@freezed
class CareGuideState with _$CareGuideState {
  const factory CareGuideState({
    @Default(CareGuideTab.articles) CareGuideTab activeTab,
    @Default([]) List<Map<String, String>> articles,
    @Default([]) List<Map<String, String>> videos,
  }) = _CareGuideState;
}
