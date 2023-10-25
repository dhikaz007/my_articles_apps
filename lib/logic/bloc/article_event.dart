part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

//class FetchArticle extends ArticleEvent {}

//* For method ResponseAPI
class GetArticle extends ArticleEvent {}
