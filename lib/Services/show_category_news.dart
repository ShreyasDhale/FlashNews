import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categoryNews = [];

  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7366a0d1ec7b401a95684f146a1ca4d1";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null &&
            article['description'] != null &&
            article['title'] != null) {
          ShowCategoryModel articleModel = ShowCategoryModel(
              author: article['author'],
              title: article['title'],
              desc: article['description'],
              url: article['url'],
              imageUrl: article['urlToImage'],
              content: article['content']);
          categoryNews.add(articleModel);
        }
      });
    }
  }
}
