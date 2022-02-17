import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future getNews({String? category}) async {
    String kDailyhuntEndpoint =
        'https://dailyhunt-api.vercel.app/dailyhunt?category=$category&items=30';
    String kinshortsEndpoint =
        'https://inshorts-api.vercel.app/shorts?category=$category';

    http.Client client = http.Client();
    http.Response response = await client.get(Uri.parse(kinshortsEndpoint));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData['success'] == true) {
        jsonData['data'].forEach((element) {
          if (element['imageUrl'] != "" &&
              element['content'] != "" &&
              element['read_more_url'] != null) {
            ArticleModel articleModel = ArticleModel(
              publishedDate: element['date'].toString(),
              publishedTime: element['time'].toString(),
              image: element['img_url'].toString(),
              content: element['content'].toString(),
              fullArticle: element['read_more_url'].toString(),
              title: element['title'].toString(),
            );
            news.add(articleModel);
          }
        });
      } else {
        print('ERROR');
      }
    }
  }
}
