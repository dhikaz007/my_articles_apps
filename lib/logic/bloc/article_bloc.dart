import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/articles.dart';
//import '../../data/model/article_model.dart';
import '../../data/repositories/articles_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticlesRepositoryImpl articlesRepositoryImpl;
  ArticleBloc({required this.articlesRepositoryImpl})
      : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) async {
      emit(ArticleLoading());
      try {
        final article = await articlesRepositoryImpl.getArticles();
        emit(ArticleLoaded(article: article));
      } catch (e) {
        emit(ArticleError(errorMessage: e.toString()));
      }
    });
  }
}
