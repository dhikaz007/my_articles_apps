part of 'widgets.dart';

class ArticleVerticalWidget extends StatefulWidget {
  final Articles articles;
  const ArticleVerticalWidget({super.key, required this.articles});

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
    final date = DateTime.parse(widget.articles.created);
    final dateFormat = DateFormat('d MMMM y,').add_Hms().format(date);

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.primaryGreenAccent15,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: widget.articles.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        if (url.isNotEmpty) {
                          return const ColorShimmer(
                            w: 80,
                            h: 80,
                          );
                        }
                        return Image.asset(
                          'assets/png/no_image.png',
                          width: 80,
                          height: 80,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 255,
                    height: 50,
                    child: FutureBuilder(
                      future:
                          translator.translate(widget.articles.title, to: code),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ColorShimmer(
                            w: 210,
                            h: 38,
                          );
                        } else {
                          if (snapshot.hasData) {
                            return AppText(
                              context: context,
                              text: snapshot.data?.text ?? '-',
                              style: AppTextStyle.font_16,
                              fontWeight: AppFontWeight.normal,
                              color: AppColors.primaryBlack,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return AppText(
                            context: context,
                            text: 'Data empty',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.bold,
                            color: AppColors.primaryBlack,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: translator.translate(widget.articles.content, to: code),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ColorShimmer(
                      w: double.maxFinite,
                      h: 57,
                    );
                  } else {
                    if (snapshot.hasData) {
                      return AppText(
                        context: context,
                        text: snapshot.data?.text ?? '-',
                        style: AppTextStyle.font_16,
                        fontWeight: AppFontWeight.normal,
                        color: AppColors.primaryBlack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return AppText(
                      context: context,
                      text: 'Data empty',
                      style: AppTextStyle.font_16,
                      fontWeight: AppFontWeight.medium,
                      color: AppColors.primaryBlack,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 1500)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Align(
                      alignment: Alignment.bottomRight,
                      child: ColorShimmer(
                        w: 180,
                        h: 19,
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        context: context,
                        text: dateFormat,
                        style: AppTextStyle.font_16,
                        fontWeight: AppFontWeight.normal,
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
