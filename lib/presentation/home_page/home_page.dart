part of 'screens.dart';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String code = 'en';

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  void getLanguage() async {
    code = await GetLanguage.currentLanguage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.sizeOf(context).width;
    final heightSize = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    context: context,
                    text: '${AppLocalizations.of(context)?.welcome}, ',
                    style: AppTextStyle.title1,
                    fontWeight: CustomFontWeight.normal,
                    color: AppColors.primaryBlack,
                  ),
                  AppText(
                    context: context,
                    text: ' ${widget.user.split('.').first}',
                    style: AppTextStyle.title1,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.primaryBlack,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Modular.to.pushNamed('/select-language'),
                    child: SvgPicture.asset('assets/svg/globe.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 180,
                child: BlocConsumer<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleError) {
                      Center(
                        child: AppText(
                          context: context,
                          text: state.errorMessage,
                          style: AppTextStyle.title2,
                          fontWeight: CustomFontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ArticleLoading) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) => const RectangleShimmer(
                          w: 220,
                          h: 180,
                        ),
                      );
                    } else if (state is ArticleLoaded) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.article.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) =>
                            ArticleHorizontalWidget(
                          articles: state.article[index],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: widthSize,
                height: heightSize * 0.65,
                child: BlocConsumer<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleError) {
                      Center(
                        child: AppText(
                          context: context,
                          text: state.errorMessage,
                          style: AppTextStyle.title2,
                          fontWeight: CustomFontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ArticleLoading) {
                      return ListView.separated(
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) => const RectangleShimmer(
                          w: double.maxFinite,
                          h: 220,
                        ),
                      );
                    } else if (state is ArticleLoaded) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.article.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) => ArticleVerticalWidget(
                          articles: state.article[index],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
