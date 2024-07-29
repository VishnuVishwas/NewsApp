// models/show_category_news.dart

// for categories_news.dart

import 'dart:convert';

import 'package:quick_news/pages/categories_news.dart';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

import '../models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categoriesList = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=9f9372cd86944ee2965054e494c9ce9e';

    // get data
    var response = await http.get(Uri.parse(url));

    // convert data
    var jsonData = jsonDecode(response.body);

    // check the status
    if (jsonData['status'] == 'ok') {
      // for loop to get all the details from api
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ShowCategoryModel showCategoryModel = ShowCategoryModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          categoriesList.add(showCategoryModel);
        }
      });
    }
  }
}
