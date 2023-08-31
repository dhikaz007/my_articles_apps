import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../logic/bloc/article_bloc.dart';
import 'widget/article_horizontal_widget.dart';
import 'widget/article_vertical_widget.dart';

class HomePage extends StatelessWidget {
  final String user;
  const HomePage({super.key, required this.user});

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
              Wrap(
                spacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  AppText(
                    context: context,
                    text: 'Welcome,',
                    style: AppTextStyle.title1,
                    fontWeight: CustomFontWeight.normal,
                    color: AppColors.primaryBlack,
                  ),
                  AppText(
                    context: context,
                    text: user.split('.').first,
                    style: AppTextStyle.title1,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.primaryBlack,
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
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.jadeJewel),
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
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.jadeJewel),
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
