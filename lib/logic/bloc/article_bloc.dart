import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/articles.dart';
//import '../../data/model/arti``cle_model.dart';
import '../../data/repositories/articles_repository.dart';
import '../../utils/utils.dart';

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

    //* For method ResponseAPI
    on<GetArticle>((event, emit) async {
      try {
        emit(ArticleLoading());
        ResponseAPI<List<Articles>> responseAPI =
            await articlesRepositoryImpl.loadArticles();
        if (responseAPI.statusCode == 200) {
          emit(ArticleLoaded(article: responseAPI.data ?? []));
        } else {
          emit(ArticleError(errorMessage: responseAPI.message));
        }
      } catch (e) {
        emit(ArticleError(errorMessage: e.toString()));
      }
    });
  }
}
