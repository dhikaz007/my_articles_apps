part of 'repositories.dart';

abstract class ArticlesRepository {
  Future<List<Article>> fetchArticles();
  Future<List<Articles>> getArticles();
  Future<ResponseAPI<List<Articles>>> loadArticles();
}

class ArticlesRepositoryImpl extends ArticlesRepository {
  @override
  Future<List<Article>> fetchArticles() async {
    final json =
        await DioNetworkArticles().getArticles(endpoint: ApiEndpoint.articles);
    if (json.statusCode == 200) {
      final data = ArticleModel.fromJson(json.data);
      return data.articles;
    } else {
      return <Article>[];
    }
  }

  //* If JSON Result not in List, this is a method to convert to List
  @override
  Future<List<Articles>> getArticles() async {
    final json =
        await DioNetworkArticles().getArticles(endpoint: ApiEndpoint.articles);
    if (json.data['code'] == 200 && json.data['status'] == true) {
      debugPrint('ARTICLE CODENYA: ${json.data['code']}');
      debugPrint('ARTICLE STATUSNYA: ${json.data['status']}');
      final data = (json.data['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return data;
    } else {
      return [];
    }
  }

  //* For method ResponseAPI
  @override
  Future<ResponseAPI<List<Articles>>> loadArticles() async {
    final json = await DioNetworkArticles()
        .fetchArticles(endpoint: ApiEndpoint.articles);
    if (json.data['code'] == 200 && json.data['status'] == true) {
      debugPrint('ARTICLE CODENYA: ${json.data['code']}');
      debugPrint('ARTICLE STATUSNYA: ${json.data['status']}');
      final dataArticles = (json.data['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return ResponseAPI(message: json.data['message'], data: dataArticles);
    } else {
      return ResponseAPI(
        message: json.data['message'],
        statusCode: json.data['code'],
        error: jsonEncode(json.data['errors']),
        status: json.data['status'],
      );
    }
  }
}
