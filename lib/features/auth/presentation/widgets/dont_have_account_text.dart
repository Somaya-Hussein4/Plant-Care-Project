import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theming/style.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account?',
              style: TextStyles.font14DarkGrey400Weight,
            ),
            TextSpan(
              text: ' SignUp',
              style: TextStyles.font14Olive400Weight,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed('signup');
                },
            ),
          ],
        ),
      ),
    );
  }
}
