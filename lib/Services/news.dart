import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/Models/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  String year = DateTime.now().year.toString();
  String month = (DateTime.now().month - 1).toString();
  String day = DateTime.now().day.toString();

  Future<void> getNews() async {
    try {
      String url =
          "https://newsapi.org/v2/everything?q=tesla&limit=20&from=$year-$month-$day&sortBy=publishedAt&apiKey=7366a0d1ec7b401a95684f146a1ca4d1";
      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((article) {
          if (article['urlToImage'] != null &&
              article['description'] != null &&
              article['title'] != null) {
            ArticleModel articleModel = ArticleModel(
                author: article['author'],
                title: article['title'],
                desc: article['description'],
                url: article['url'],
                imageUrl: article['urlToImage'],
                content: article['content']);
            news.add(articleModel);
          }
        });
      }
    } on HttpException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print(e.message);
    }
  }
}
