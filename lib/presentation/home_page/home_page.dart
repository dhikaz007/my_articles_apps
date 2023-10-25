part of 'screens.dart';

class HomePage extends StatefulWidget {
  final UserResponse user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String code = 'en';

  @override
  void initState() {
    getLanguage();
    BlocProvider.of<ArticleBloc>(context).add(GetArticle());
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
            top: 20,
            left: 20,
            right: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 1500)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientShimmer(
                          w: 144,
                          h: 24,
                        ),
                        GradientShimmer(
                          w: 80,
                          h: 24,
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        AppText(
                          context: context,
                          text: '${AppLocalizations.of(context)?.welcome}, ',
                          style: AppTextStyle.font_20,
                          fontWeight: AppFontWeight.normal,
                          color: AppColors.primaryBlack,
                        ),
                        AppText(
                          context: context,
                          text: ' ${widget.user.name.split(' ').first}',
                          style: AppTextStyle.font_20,
                          fontWeight: AppFontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => BlocProvider.of<ArticleBloc>(context)
                              .add(GetArticle()),
                          child: const Icon(Icons.refresh),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => Modular.to.pushNamed('/select-language'),
                          child: SvgPicture.asset('assets/svg/globe.svg'),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  debugPrint('TOP ARTICLE STATE $state');
                  if (state is ArticleLoading) {
                    return SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) => const GradientShimmer(
                          w: 189,
                          h: 152,
                        ),
                      ),
                    );
                  }
                  if (state is ArticleError) {
                    return Center(
                      child: AppText(
                        context: context,
                        text: state.errorMessage,
                        style: AppTextStyle.font_20,
                        fontWeight: AppFontWeight.bold,
                        color: Colors.red,
                      ),
                    );
                  }
                  if (state is ArticleLoaded) {
                    return SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.article.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) =>
                            ArticleHorizontalWidget(
                          articles: state.article[index],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  debugPrint('BOTTOM ARTICLE STATE $state');
                  if (state is ArticleError) {
                    Center(
                      child: AppText(
                        context: context,
                        text: state.errorMessage,
                        style: AppTextStyle.font_20,
                        fontWeight: AppFontWeight.bold,
                        color: Colors.red,
                      ),
                    );
                  } else if (state is ArticleLoading) {
                    return SizedBox(
                      width: widthSize,
                      height: heightSize * 0.65,
                      child: ListView.separated(
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) => const GradientShimmer(
                          w: double.maxFinite,
                          h: 200,
                        ),
                      ),
                    );
                  } else if (state is ArticleLoaded) {
                    return SizedBox(
                      width: widthSize,
                      height: heightSize * 0.65,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.article.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) => ArticleVerticalWidget(
                          articles: state.article[index],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
