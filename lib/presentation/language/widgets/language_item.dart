import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';

class LanguageItem extends StatelessWidget {
  final String title;
  final String lang;
  final bool isSelected;
  const LanguageItem({
    super.key,
    required this.title,
    required this.lang,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.blueFlax,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/$lang.svg',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          AppText(
            context: context,
            text: title,
            style: AppTextStyle.title2,
            fontWeight: CustomFontWeight.medium,
            color: AppColors.primaryBlack,
          ),
          const Spacer(),
          isSelected
              ? SvgPicture.asset(
                  'assets/svg/radio_button_filled.svg',
                  fit: BoxFit.contain,
                )
              : SvgPicture.asset(
                  'assets/svg/radio_button_unfilled.svg',
                  fit: BoxFit.contain,
                ),
        ],
      ),
    );
  }
}
