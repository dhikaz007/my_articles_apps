import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import '../../../widgets/rectangle_shimmer.dart';

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
            FutureBuilder(
              future: GoogleTranslator().translate(title, to: 'en'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const RectangleShimmer();
                } else {
                  if (snapshot.hasData) {
                    return AppText(
                      context: context,
                      text: snapshot.data?.text ?? '-',
                      style: AppTextStyle.title2,
                      fontWeight: CustomFontWeight.bold,
                      color: AppColors.jadeJewel,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                  return AppText(
                    context: context,
                    text: 'Data empty',
                    style: AppTextStyle.title3,
                    fontWeight: CustomFontWeight.medium,
                    color: AppColors.primaryBlack,
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            FutureBuilder(
              future: GoogleTranslator().translate(content, to: 'en'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const RectangleShimmer(
                    h: 120,
                  );
                } else {
                  if (snapshot.hasData) {
                    return AppText(
                      context: context,
                      text: snapshot.data?.text ?? '-',
                      style: AppTextStyle.body1,
                      fontWeight: CustomFontWeight.normal,
                      color: AppColors.primaryBlack,
                      maxLines: 8,
                      textAlign: TextAlign.left,
                    );
                  }
                  return AppText(
                    context: context,
                    text: 'Data empty',
                    style: AppTextStyle.title3,
                    fontWeight: CustomFontWeight.normal,
                    color: AppColors.primaryBlack,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
