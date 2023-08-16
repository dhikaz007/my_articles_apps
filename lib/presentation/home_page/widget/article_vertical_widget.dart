import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';

class ArticleVerticalWidget extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final String createdAt;
  const ArticleVerticalWidget({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(createdAt);
    final dateFormat = DateFormat('d MMMM y,').add_Hms().format(date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.blueFlax,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.jadeJewel),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 80,
                    child: AppText(
                      context: context,
                      text: title,
                      style: AppTextStyle.title3,
                      fontWeight: CustomFontWeight.medium,
                      color: AppColors.primaryBlack,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AppText(
                context: context,
                text: content,
                style: AppTextStyle.body1,
                fontWeight: CustomFontWeight.normal,
                color: AppColors.primaryBlack,
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: AppText(
                  context: context,
                  text: dateFormat,
                  style: AppTextStyle.body1,
                  fontWeight: CustomFontWeight.normal,
                  color: AppColors.primaryBlack,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
