import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future getNews({String? category}) async {
    String kDailyhuntEndpoint =
        'https://dailyhunt-api.vercel.app/dailyhunt?category=$category&items=30';
    String kinshortsEndpoint =
        'https://inshorts-api.vercel.app/shorts?category=all';

    if (category != 'all') {
      http.Client client = http.Client();
      http.Response response = await client.get(Uri.parse(kDailyhuntEndpoint));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          jsonData['data'].forEach((element) {
            if (element['imageUrl'] != "" && element['content'] != "") {
              List<String> raw = element['PublishedTime'].split(" ");
              String date = raw[0];
              String time = raw[1];
              ArticleModel articleModel = ArticleModel(
                publishedDate: date,
                publishedTime: time,
                image: element['imageUrl'].toString(),
                content: element['content'].toString(),
                fullArticle: element['publisherStory'].toString(),
                views: element['viewCount'].toString(),
                title: element['title'].toString(),
              );
              news.add(articleModel);
            }
          });
        } else {
          print('ERROR');
        }
      }
    } else {
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
                views: "", // empty string as inshorts doesn't provide views
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
}
