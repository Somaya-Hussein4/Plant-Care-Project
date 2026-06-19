import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => BlocProvider.value(
      value: context.read<LanguageCubit>(),
      child: const _LanguageBottomSheetContent(),
    ),
  );
}

class _LanguageBottomSheetContent extends StatelessWidget {
  const _LanguageBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, currentLocale) {
        return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: SafeArea(
              // ← this handles the nav bar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Text(
                    S.of(context).languages,
                    style: TextStyles.font18darkGreen600Weight,
                  ),
                  SizedBox(height: 20),
                  _LanguageOption(
                    label: 'English',
                    languageCode: 'en',
                    isSelected: currentLocale.languageCode == 'en',
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage('en');
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _LanguageOption(
                    label: 'العربية',
                    languageCode: 'ar',
                    isSelected: currentLocale.languageCode == 'ar',
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage('ar');
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ));
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final String languageCode;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.languageCode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.primaryGreen.withOpacity(0.12)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? ColorsManager.primaryGreen : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(
              languageCode == 'en' ? '🇬🇧' : '🇵🇸',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: isSelected
                  ? TextStyles.font16darkGreen600Weight
                  : TextStyles.font16darkGreen400Weight,
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: ColorsManager.primaryGreen,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
