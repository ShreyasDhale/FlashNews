import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Models/article.dart';
import 'package:news_app/Models/slider.dart';
import 'package:news_app/Pages/ArticleView.dart';
import 'package:news_app/Services/breaking_news.dart';
import 'package:news_app/Services/news.dart';
import 'package:news_app/vars/globals.dart';

class AllNews extends StatefulWidget {
  final String news;
  final Function toogleTheme;
  const AllNews({super.key, required this.news, required this.toogleTheme});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> slidersList = [];
  List<ArticleModel> articleList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
    getSlider();
  }

  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    print(newsClass.news.length);
    setState(() {
      articleList = newsClass.news;
    });
  }

  void getSlider() async {
    SliderNews newsClass = SliderNews();
    await newsClass.getNews();
    setState(() {
      slidersList = newsClass.breakingNews;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.news,
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
              widget.toogleTheme();
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(animation)
                      : Tween<double>(begin: 0.75, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                currentTheme.brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.sunny,
                key: ValueKey(
                  currentTheme.brightness == Brightness.light
                      ? 'icon1'
                      : 'icon2',
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: loading
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
                  itemCount: (widget.news == "Breaking")
                      ? slidersList.length
                      : articleList.length,
                  itemBuilder: (context, index) {
                    return AllNewsTile(
                        toggleTheme: widget.toogleTheme,
                        url: (widget.news == "Breaking")
                            ? slidersList[index].url!
                            : articleList[index].url!,
                        image: (widget.news == "Breaking")
                            ? slidersList[index].imageUrl!
                            : articleList[index].imageUrl!,
                        desc: (widget.news == "Breaking")
                            ? slidersList[index].desc!
                            : articleList[index].desc!,
                        title: (widget.news == "Breaking")
                            ? slidersList[index].title!
                            : articleList[index].title!);
                  }),
            ),
    );
  }
}

class AllNewsTile extends StatelessWidget {
  final String image, desc, title, url;
  final Function toggleTheme;
  const AllNewsTile(
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
