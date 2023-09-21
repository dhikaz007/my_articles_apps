import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../core/localizations/app_localizations.dart';
import '../../helpers/get_language.dart';
import '../../logic/bloc/article_bloc.dart';
import '../../widgets/rectangle_shimmer.dart';
import 'widget/article_horizontal_widget.dart';
import 'widget/article_vertical_widget.dart';

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
                child: BlocBuilder<ArticleBloc, ArticleState>(
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
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.article.length,
                        itemBuilder: (context, index) =>
                            ArticleHorizontalWidget(
                          title: state.article[index].title,
                          content: state.article[index].content,
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
                child: BlocBuilder<ArticleBloc, ArticleState>(
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
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.article.length,
                        itemBuilder: (context, index) => ArticleVerticalWidget(
                          image: state.article[index].image,
                          title: state.article[index].title,
                          content: state.article[index].content,
                          createdAt: state.article[index].created,
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
