// slider_data.dart
// get from model/slider_model.dart API news

import 'dart:convert';

import 'package:quick_news/models/slider_model.dart';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class SliderClass {
  List<SliderModel> sliders = [];

  Future<void> getSlidersCategories() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9f9372cd86944ee2965054e494c9ce9e';

    // get data
    var response = await http.get(Uri.parse(url));

    // convert data
    var jsonData = jsonDecode(response.body);

    // check the status
    if (jsonData['status'] == 'ok') {
      // for loop to get all the details from api
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          SliderModel sliderModel = SliderModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}
