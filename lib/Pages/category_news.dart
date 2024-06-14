import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Models/category.dart';
import 'package:news_app/Pages/ArticleView.dart';
import 'package:news_app/Services/show_category_news.dart';
import 'package:news_app/vars/globals.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  final Function toggleTheme;
  const CategoryNews(
      {super.key, required this.toggleTheme, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> catogaryList = [];
  bool loader = true;

  @override
  void initState() {
    super.initState();
    getCatogeryNews();
  }

  void getCatogeryNews() async {
    ShowCategoryNews newsClass = ShowCategoryNews();
    await newsClass.getNews(widget.name.toLowerCase());
    print(newsClass.categoryNews.length);
    setState(() {
      catogaryList = newsClass.categoryNews;
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: style.copyWith(color: Colors.blue),
            ),
            Text(
              "News",
              style: style.copyWith(color: Colors.red),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.toggleTheme();
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 900),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(animation)
                      : Tween<double>(begin: 0.75, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                AppTheme.currentTheme.brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.sunny,
                key: ValueKey(
                  AppTheme.currentTheme.brightness == Brightness.light
                      ? 'icon1'
                      : 'icon2',
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: loader
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.blue,
                rightDotColor: Colors.pink,
                size: 50,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                  itemCount: catogaryList.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                        toggleTheme: widget.toggleTheme,
                        url: catogaryList[index].url!,
                        image: catogaryList[index].imageUrl!,
                        desc: catogaryList[index].desc!,
                        title: catogaryList[index].title!);
                  }),
            ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  final Function toggleTheme;
  const ShowCategory(
      {super.key,
      required this.image,
      required this.desc,
      required this.title,
      required this.url,
      required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ArticleView(blogUrl: url, toggleTheme: toggleTheme))),
      child: Card(
        elevation: 12,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.flickr(
                        leftDotColor: Colors.blue,
                        rightDotColor: Colors.pink,
                        size: 30,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'Assets/Images/placeholder.png',
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  title,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  desc,
                  style: style.copyWith(color: Colors.grey),
                )
              ],
            )),
      ),
    );
  }
}
