import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/home/logic/home_cubit.dart';
import 'package:graduation_project/features/home/logic/home_state.dart';
import 'package:graduation_project/features/home/presentation/widgets/choose-from-gallery.dart';
import 'package:graduation_project/features/home/presentation/widgets/scan-card.dart';
import 'package:graduation_project/features/home/presentation/widgets/tips_card.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeNavigateToResult) {
          context.pushNamed('result', extra: state.path);

          context.read<HomeCubit>().reset();
        }
      },
      // your existing home page widget

      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppText(title: (context) => S.of(context).pageTitle),
              SizedBox(height: 30.h),
              Text(
                S.of(context).scanTitle,
                style: TextStyles.font18DarkGreen400Weight,
              ),
              Text(
                S.of(context).scanSubtitle,
                style: TextStyles.font18DarkGreen400Weight,
              ),
              SizedBox(height: 20.h),
              ScanCard(
                onScanTap: () => context
                    .read<HomeCubit>()
                    .handleImageSelection(ImageSource.camera),
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(color: ColorsManager.secondaryGreen)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.h),
                      child: Text(
                        S.of(context).or,
                        style: TextStyles.font18DarkGreen400Weight,
                      ),
                    ),
                    Expanded(
                        child: Divider(color: ColorsManager.secondaryGreen)),
                  ],
                ),
              ),
              ChooseFromGalleryButton(
                onTap: () => context
                    .read<HomeCubit>()
                    .handleImageSelection(ImageSource.gallery),
              ),
              TipsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
