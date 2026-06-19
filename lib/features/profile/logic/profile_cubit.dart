import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/profile/data/repository/profile_repo.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState.initial());

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    try {
      final user = await _repository.getProfileImage();
      emit(ProfileState.loaded(user));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    // Keep showing current user while uploading
    final currentUser = state.maybeWhen(
      loaded: (user) => user,
      orElse: () => null,
    );

    if (currentUser != null) {
      emit(ProfileState.uploading(currentUser));
    } else {
      emit(const ProfileState.loading());
    }

    try {
      final updatedUser = await _repository.uploadProfileImage(imageFile);
      emit(ProfileState.uploadSuccess(updatedUser));
      // Settle into loaded state after brief success feedback
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileState.loaded(updatedUser));
    } catch (e) {
      // On failure, revert to loaded with old user if possible
      if (currentUser != null) {
        emit(ProfileState.loaded(currentUser));
      } else {
        emit(ProfileState.error(e.toString()));
      }
    }
  }
}
