part of 'widgets.dart';

class ArticleHorizontalWidget extends StatefulWidget {
  final Articles articles;
  const ArticleHorizontalWidget({
    super.key,
    required this.articles,
  });

  @override
  State<ArticleHorizontalWidget> createState() =>
      _ArticleHorizontalWidgetState();
}

class _ArticleHorizontalWidgetState extends State<ArticleHorizontalWidget> {
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
    return Container(
      padding: const EdgeInsets.all(8),
      width: 220,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlack),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
          BoxShadow(
            color: AppColors.primaryWhite,
            offset: const Offset(-10, 0),
            //blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: translator.translate(widget.articles.title, to: code),
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
            future: translator.translate(widget.articles.content, to: code),
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
    );
  }
}
