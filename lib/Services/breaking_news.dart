import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/slider.dart';

class SliderNews {
  String url =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7366a0d1ec7b401a95684f146a1ca4d1";
  List<SliderModel> breakingNews = [];

  Future<void> getNews() async {
    try {
      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((article) {
          if (article['urlToImage'] != null &&
              article['description'] != null &&
              article['title'] != null) {
            SliderModel sliderModel = SliderModel(
                author: article['author'],
                title: article['title'],
                desc: article['description'],
                url: article['url'],
                imageUrl: article['urlToImage'],
                content: article['content']);
            breakingNews.add(sliderModel);
          }
        });
      }
    } on HttpException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print(e.message);
    }
  }
}
