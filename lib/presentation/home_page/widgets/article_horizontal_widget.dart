part of 'widgets.dart';

class ArticleHorizontalWidget extends StatefulWidget {
  final Articles articles;
  const ArticleHorizontalWidget({super.key, required this.articles});

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
      width: 210,
      //height: 220,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryGreen),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.primaryGrey,
        //     offset: const Offset(0, 5),
        //     blurRadius: 5,
        //   ),
        //   BoxShadow(
        //     color: AppColors.primaryWhite,
        //     offset: Offset(-10, 0),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: translator.translate(widget.articles.title, to: code),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              } else {
                if (snapshot.hasData) {
                  return AppText(
                    context: context,
                    text: snapshot.data?.text ?? '-',
                    style: AppTextStyle.font_16,
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.primaryGreen,
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
          const SizedBox(height: 4),
          FutureBuilder(
            future: translator.translate(widget.articles.content, to: code),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              } else {
                if (snapshot.hasData) {
                  return AppText(
                    context: context,
                    text: snapshot.data?.text ?? '-',
                    style: AppTextStyle.font_16,
                    fontWeight: AppFontWeight.normal,
                    color: AppColors.primaryBlack,
                    maxLines: 7,
                    textAlign: TextAlign.left,
                  );
                }
                return AppText(
                  context: context,
                  text: 'Data empty',
                  style: AppTextStyle.font_16,
                  fontWeight: AppFontWeight.normal,
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
