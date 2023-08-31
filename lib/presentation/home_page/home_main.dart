import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/articles_repository.dart';
import '../../logic/bloc/article_bloc.dart';
import 'home_page.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleBloc(
        articlesRepositoryImpl: ArticlesRepositoryImpl(),
      )..add(
          GetArticle(),
        ),
      child: const HomePage(),
    );
  }
}
