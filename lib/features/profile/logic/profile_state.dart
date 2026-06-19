import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/profile/data/models/profile_image_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(ProfileUserModel user) = _Loaded;
  const factory ProfileState.uploading(ProfileUserModel user) = _Uploading;
  const factory ProfileState.uploadSuccess(ProfileUserModel user) =
      _UploadSuccess;
  const factory ProfileState.error(String message) = _Error;
}
