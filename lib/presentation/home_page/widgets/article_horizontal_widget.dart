part of 'widgets.dart';

class ArticleHorizontalWidget extends StatefulWidget {
  final String title;
  final String content;
  const ArticleHorizontalWidget({
    super.key,
    required this.title,
    required this.content,
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
      width: 220,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 4,
          ),
        ],
      ),
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
              future: translator.translate(widget.title, to: code),
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
              future: translator.translate(widget.content, to: code),
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
