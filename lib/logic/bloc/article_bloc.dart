import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repositories/repositories.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    final ArticlesRepositoryImpl articlesRepositoryImpl =
        ArticlesRepositoryImpl();
    // on<FetchArticle>((event, emit) async {
    //   emit(ArticleLoading());
    //   try {
    //     final article = await articlesRepositoryImpl.getArticles();
    //     emit(ArticleLoaded(article: article));
    //   } catch (e) {
    //     emit(ArticleError(errorMessage: e.toString()));
    //   }
    // });

    //* For method ResponseAPI
    on<GetArticle>((event, emit) async {
      try {
        emit(ArticleLoading());
        final responseAPI = await articlesRepositoryImpl.loadArticles();
        emit(ArticleLoaded(article: responseAPI.data ?? []));
      } catch (e) {
        emit(ArticleError(errorMessage: e.toString()));
      }
    });
  }
}
