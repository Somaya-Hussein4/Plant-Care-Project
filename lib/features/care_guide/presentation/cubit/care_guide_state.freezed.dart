// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_guide_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CareGuideState {
  CareGuideTab get activeTab => throw _privateConstructorUsedError;
  List<Map<String, String>> get articles => throw _privateConstructorUsedError;
  List<Map<String, String>> get videos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CareGuideStateCopyWith<CareGuideState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareGuideStateCopyWith<$Res> {
  factory $CareGuideStateCopyWith(
          CareGuideState value, $Res Function(CareGuideState) then) =
      _$CareGuideStateCopyWithImpl<$Res, CareGuideState>;
  @useResult
  $Res call(
      {CareGuideTab activeTab,
      List<Map<String, String>> articles,
      List<Map<String, String>> videos});
}

/// @nodoc
class _$CareGuideStateCopyWithImpl<$Res, $Val extends CareGuideState>
    implements $CareGuideStateCopyWith<$Res> {
  _$CareGuideStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTab = null,
    Object? articles = null,
    Object? videos = null,
  }) {
    return _then(_value.copyWith(
      activeTab: null == activeTab
          ? _value.activeTab
          : activeTab // ignore: cast_nullable_to_non_nullable
              as CareGuideTab,
      articles: null == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      videos: null == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CareGuideStateImplCopyWith<$Res>
    implements $CareGuideStateCopyWith<$Res> {
  factory _$$CareGuideStateImplCopyWith(_$CareGuideStateImpl value,
          $Res Function(_$CareGuideStateImpl) then) =
      __$$CareGuideStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CareGuideTab activeTab,
      List<Map<String, String>> articles,
      List<Map<String, String>> videos});
}

/// @nodoc
class __$$CareGuideStateImplCopyWithImpl<$Res>
    extends _$CareGuideStateCopyWithImpl<$Res, _$CareGuideStateImpl>
    implements _$$CareGuideStateImplCopyWith<$Res> {
  __$$CareGuideStateImplCopyWithImpl(
      _$CareGuideStateImpl _value, $Res Function(_$CareGuideStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTab = null,
    Object? articles = null,
    Object? videos = null,
  }) {
    return _then(_$CareGuideStateImpl(
      activeTab: null == activeTab
          ? _value.activeTab
          : activeTab // ignore: cast_nullable_to_non_nullable
              as CareGuideTab,
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      videos: null == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ));
  }
}

/// @nodoc

class _$CareGuideStateImpl implements _CareGuideState {
  const _$CareGuideStateImpl(
      {this.activeTab = CareGuideTab.articles,
      final List<Map<String, String>> articles = const [],
      final List<Map<String, String>> videos = const []})
      : _articles = articles,
        _videos = videos;

  @override
  @JsonKey()
  final CareGuideTab activeTab;
  final List<Map<String, String>> _articles;
  @override
  @JsonKey()
  List<Map<String, String>> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  final List<Map<String, String>> _videos;
  @override
  @JsonKey()
  List<Map<String, String>> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  @override
  String toString() {
    return 'CareGuideState(activeTab: $activeTab, articles: $articles, videos: $videos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareGuideStateImpl &&
            (identical(other.activeTab, activeTab) ||
                other.activeTab == activeTab) &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            const DeepCollectionEquality().equals(other._videos, _videos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeTab,
      const DeepCollectionEquality().hash(_articles),
      const DeepCollectionEquality().hash(_videos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CareGuideStateImplCopyWith<_$CareGuideStateImpl> get copyWith =>
      __$$CareGuideStateImplCopyWithImpl<_$CareGuideStateImpl>(
          this, _$identity);
}

abstract class _CareGuideState implements CareGuideState {
  const factory _CareGuideState(
      {final CareGuideTab activeTab,
      final List<Map<String, String>> articles,
      final List<Map<String, String>> videos}) = _$CareGuideStateImpl;

  @override
  CareGuideTab get activeTab;
  @override
  List<Map<String, String>> get articles;
  @override
  List<Map<String, String>> get videos;
  @override
  @JsonKey(ignore: true)
  _$$CareGuideStateImplCopyWith<_$CareGuideStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
