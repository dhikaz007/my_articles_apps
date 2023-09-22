part of 'widgets.dart';

class ArticleVerticalWidget extends StatefulWidget {
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
  State<ArticleVerticalWidget> createState() => _ArticleVerticalWidgetState();
}

class _ArticleVerticalWidgetState extends State<ArticleVerticalWidget> {
  late GoogleTranslator translator;
  String code = 'en';

  @override
  void initState() {
    getCode();
    translator = GoogleTranslator();
    super.initState();
  }

  void getCode() async {
    code = await LanguageStorage.getCode() ?? 'en';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(widget.createdAt);
    final dateFormat = DateFormat('d MMMM y,').add_Hms().format(date);

    return Container(
      width: double.maxFinite,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: AppColors.jadeJewel.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
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
                      imageUrl: widget.image,
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
                      future:
                          GoogleTranslator().translate(widget.title, to: code),
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
                future: GoogleTranslator().translate(widget.content, to: code),
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
