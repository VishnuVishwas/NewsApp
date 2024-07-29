// news.dart
// get from model/article_model.dart API news

import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/everything?q=apple&from=2024-07-27&to=2024-07-27&sortBy=popularity&apiKey=9f9372cd86944ee2965054e494c9ce9e';

    // get data
    var response = await http.get(Uri.parse(url));

    // convert data
    var jsonData = jsonDecode(response.body);

    // check the status
    if (jsonData['status'] == 'ok') {
      // for loop to get all the details from api
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
