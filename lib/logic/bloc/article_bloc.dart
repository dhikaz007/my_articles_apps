import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/article_model.dart';
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
        final article = await articlesRepositoryImpl.fetchArticles();
        emit(ArticleLoaded(article: article));
      } catch (e) {
        emit(ArticleError(errorMessage: e.toString()));
      }
    });
  }
}
