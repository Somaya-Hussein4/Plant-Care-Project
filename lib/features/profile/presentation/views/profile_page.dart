import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';
import 'package:graduation_project/features/profile/data/models/profile_image_model.dart';
import 'package:graduation_project/features/profile/logic/profile_cubit.dart';
import 'package:graduation_project/features/profile/logic/profile_state.dart';
import 'package:graduation_project/features/profile/presentation/widgets/language_bottom_sheet.dart';
import 'package:graduation_project/features/profile/presentation/widgets/logout_button.dart';
import 'package:graduation_project/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:graduation_project/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:graduation_project/features/profile/presentation/widgets/profile_menu_items.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _pickAndUpload(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null || !context.mounted) return;
    context.read<ProfileCubit>().uploadProfileImage(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red),
          ),
          uploadSuccess: (_) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).profileImage),
              backgroundColor: ColorsManager.primaryGreen,
            ),
          ),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              loggedOut: () => context.go('/login'),
              failure: (error) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error))),
            );
          },
          child: Scaffold(
            body: state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (user) => _buildBody(context, user, isUploading: false),
              uploading: (user) => _buildBody(context, user, isUploading: true),
              uploadSuccess: (user) =>
                  _buildBody(context, user, isUploading: false),
              error: (msg) => Center(child: Text('Error: $msg')),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProfileUserModel user, {
    required bool isUploading,
  }) {
    final imageProvider = user.cloudProfileImage?.secureUrl != null
        ? NetworkImage(user.cloudProfileImage!.secureUrl) as ImageProvider
        : null;

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppText(
            title: (context) => S.of(context).myProfile,
          ),
          SizedBox(height: 16.h),
          Stack(
            children: [
              ProfileHeaderCard(
                avatarImage: imageProvider,
                name: user.fullName,
                onEditTap: isUploading ? () {} : () => _pickAndUpload(context),
              ),
              if (isUploading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 24.h),
          ProfileMenuItem(
            icon: Icons.language_outlined,
            label: S.of(context).languages,
            onTap: () => showLanguageBottomSheet(context),
          ),
          SizedBox(height: 20.h),
          ProfileMenuItem(
            icon: Icons.info_outline,
            label: S.of(context).aboutUs,
            onTap: () => context.push('/about'),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return LogoutButton(
                onTap: state.maybeWhen(
                  loggedOut: () => null,
                  orElse: () => () => showLogoutConfirmation(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
