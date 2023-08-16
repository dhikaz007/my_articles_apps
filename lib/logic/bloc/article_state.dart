part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Articles> article;

  const ArticleLoaded({required this.article});
}

class ArticleError extends ArticleState {
  final String errorMessage;

  const ArticleError({required this.errorMessage});
}
