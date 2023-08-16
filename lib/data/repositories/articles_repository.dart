import '../dio_network/api_endpoint.dart';
import '../dio_network/dio_network_articles.dart';
import '../model/articles.dart';
import '../model/article_model.dart';

abstract class ArticlesRepository {
  Future<List<Article>> fetchArticles();
  Future<List<Articles>> getArticles();
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
    if (json.statusCode == 200) {
      final data = (json.data['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return data;
    } else {
      return [];
    }
  }
}
