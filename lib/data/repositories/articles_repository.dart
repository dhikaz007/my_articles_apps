import '../dio_network/api_endpoint.dart';
import '../dio_network/dio_network_articles.dart';
import '../model/article_model.dart';

abstract class ArticlesRepository {
  Future<List<Article>> fetchArticles();
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
}
