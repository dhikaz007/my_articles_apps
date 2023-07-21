import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';

class ArticleHorizontalWidget extends StatelessWidget {
  final String title;
  final String content;
  const ArticleHorizontalWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 220,
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryBlack),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context: context,
              text: title,
              style: AppTextStyle.title2,
              fontWeight: CustomFontWeight.bold,
              color: AppColors.jadeJewel,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            AppText(
              context: context,
              text: content,
              style: AppTextStyle.body1,
              fontWeight: CustomFontWeight.normal,
              color: AppColors.primaryBlack,
              maxLines: 8,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
