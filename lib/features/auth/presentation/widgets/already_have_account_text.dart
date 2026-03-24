import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theming/style.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: TextStyles.font14DarkGrey400Weight,
            ),
            TextSpan(
              text: ' Login',
              style: TextStyles.font14Olive400Weight,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed('login');
                },
            ),
          ],
        ),
      ),
    );
  }
}
