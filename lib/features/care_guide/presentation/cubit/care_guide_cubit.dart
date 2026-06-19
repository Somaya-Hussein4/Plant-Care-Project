import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';

import '../../data/care_guide_data.dart';
import 'care_guide_state.dart';

class CareGuideCubit extends Cubit<CareGuideState> {
  final LanguageCubit _languageCubit;
  late final StreamSubscription<Locale> _languageSub;

  CareGuideCubit(this._languageCubit) : super(const CareGuideState()) {
    _loadForLocale(_languageCubit.state);
    _languageSub = _languageCubit.stream.listen(_loadForLocale);
  }

  void _loadForLocale(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    emit(state.copyWith(
      articles: isArabic ? CareGuideData.articlesAr : CareGuideData.articlesEn,
      videos: isArabic ? CareGuideData.videosAr : CareGuideData.videosEn,
    ));
  }

  void selectTab(CareGuideTab tab) => emit(state.copyWith(activeTab: tab));

  @override
  Future<void> close() {
    _languageSub.cancel();
    return super.close();
  }
}
