import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';
import 'package:graduation_project/features/profile/presentation/widgets/logout_button.dart';
import 'package:graduation_project/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:graduation_project/features/profile/presentation/widgets/profile_menu_items.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () => context.go('/login'),
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error))),
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppText(title: 'Profile'),
              SizedBox(height: 16.h),
              ProfileHeaderCard(
                  avatarImage: null,
                  onEditTap: () {
                    // Handle edit tap
                  }),
              SizedBox(height: 24.h),
              ProfileMenuItem(
                icon: Icons.settings,
                label: ' Settings',
              ),
              SizedBox(height: 20.h),
              ProfileMenuItem(
                icon: Icons.info_outline,
                label: ' About Us',
                onTap: () => context.push('/about'),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return LogoutButton(
                      onTap: state.maybeWhen(
                          loading: () => null,
                          orElse: () =>
                              () => context.read<AuthCubit>().logout()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
