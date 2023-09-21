import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import '../../../widgets/rectangle_shimmer.dart';

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
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) {
                        if (url.isNotEmpty) {
                          return const RectangleShimmer();
                        }
                        return AppText(
                          context: context,
                          text: 'NO IMAGE',
                          style: AppTextStyle.title3,
                          fontWeight: CustomFontWeight.bold,
                          color: AppColors.blueFlax,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: FutureBuilder(
                      future: GoogleTranslator().translate(title, to: 'en'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const RectangleShimmer();
                        } else {
                          if (snapshot.hasData) {
                            return AppText(
                              context: context,
                              text: snapshot.data?.text ?? '-',
                              style: AppTextStyle.title3,
                              fontWeight: CustomFontWeight.medium,
                              color: AppColors.primaryBlack,
                              maxLines: 2,
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
                  ),
                ],
              ),
              const SizedBox(height: 4),
              FutureBuilder(
                future: GoogleTranslator().translate(content, to: 'en'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const RectangleShimmer(
                      w: double.maxFinite,
                      h: 50,
                    );
                  } else {
                    if (snapshot.hasData) {
                      return AppText(
                        context: context,
                        text: snapshot.data?.text ?? '-',
                        style: AppTextStyle.title3,
                        fontWeight: CustomFontWeight.normal,
                        color: AppColors.primaryBlack,
                        maxLines: 2,
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
              const SizedBox(height: 20),
              FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 1500)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Align(
                      alignment: Alignment.bottomRight,
                      child: RectangleShimmer(),
                    );
                  } else {
                    return Align(
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
