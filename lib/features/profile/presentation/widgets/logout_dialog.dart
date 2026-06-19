import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';

void showLogoutConfirmation(BuildContext context) {
  // ✅ Capture the cubit here, while context is still valid
  final authCubit = context.read<AuthCubit>();

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(S.of(context).confirmLogout),
        content: Text(S.of(context).logoutConfirmation),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _performLogout(context, authCubit); // ✅ pass both
            },
            style: TextButton.styleFrom(foregroundColor: ColorsManager.red),
            child: Text(S.of(context).logout),
          ),
        ],
      );
    },
  );
}

void _performLogout(BuildContext context, AuthCubit authCubit) {
  authCubit.logout();
  context.go('/login');
}
