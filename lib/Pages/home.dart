import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Models/article.dart';
import 'package:news_app/Models/category.dart';
import 'package:news_app/Models/slider.dart';
import 'package:news_app/Pages/allNews.dart';
import 'package:news_app/Pages/category_news.dart';
import 'package:news_app/Services/breaking_news.dart';
import 'package:news_app/Services/news.dart';
import 'package:news_app/Widgets/CategoryTile.dart';
import 'package:news_app/Widgets/BlogTile.dart';
import 'package:news_app/Widgets/SliderTile.dart';
import 'package:news_app/vars/Globals.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class HomePage extends StatefulWidget {
  final Function toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoryList = [];
  List<SliderModel> slidersList = [];
  List<ArticleModel> articleList = [];
  var searchController = TextEditingController();
  bool loading = true;
  bool searchVisible = false;
  bool isSearching = false;
  int activeIndex = 0;
  String searchStr = "";
  List<ArticleModel> filteredList = [];

  @override
  void initState() {
    super.initState();
    getNews();
    getSlider();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String value) {
    setState(() {
      searchStr = value;
      filteredList = [];
    });
    List<ArticleModel> searchList = articleList.where((article) {
      return article.title!.toLowerCase().contains(searchStr.toLowerCase()) ||
          article.desc!.toLowerCase().contains(searchStr.toLowerCase());
    }).toList();
    setState(() {
      filteredList = searchList;
    });
  }

  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articleList = newsClass.news;
    });
  }

  void getSlider() async {
    SliderNews newsClass = SliderNews();
    await newsClass.getNews();
    setState(() {
      slidersList = newsClass.breakingNews;
      categoryList = CategoryModel.getCategories();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: searchVisible
              ? WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromRight(
                          duration: const Duration(milliseconds: 400)),
                  outgoingEffect:
                      WidgetTransitionEffects.outgoingSlideOutToRight(
                          duration: const Duration(milliseconds: 400)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: searchController,
                        maxLines: 1,
                        style: style.copyWith(fontSize: 16),
                        onChanged: (value) {
                          search(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          focusColor: Colors.blue,
                          hintText: "Search...",
                          hintStyle: style.copyWith(color: Colors.grey),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ))
              : WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromLeft(
                          duration: const Duration(milliseconds: 400)),
                  outgoingEffect:
                      WidgetTransitionEffects.outgoingSlideOutToLeft(
                          duration: const Duration(milliseconds: 400)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Flash",
                        style: style.copyWith(color: Colors.blue),
                      ),
                      Text(
                        "News",
                        style: style.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
          leading: IconButton(
            onPressed: () {
              widget.toggleTheme();
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
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  searchVisible = !searchVisible;
                });
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: child.key == const ValueKey('icon1')
                        ? Tween<double>(begin: 1, end: 0.75).animate(animation)
                        : Tween<double>(begin: 0.75, end: 1).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  searchVisible ? Icons.close : Icons.search,
                  key: ValueKey(
                    searchVisible ? 'icon1' : 'icon2',
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
            : SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      searchVisible
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width,
                              child: filteredList.isEmpty &&
                                      searchStr.isNotEmpty
                                  ? Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "Assets/Images/notFound.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "No News Find matching $searchStr",
                                            style: style.copyWith(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "Please Try again with another news",
                                            style: style.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w200),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))
                                  : ListView.builder(
                                      itemCount: searchStr.isEmpty
                                          ? articleList.length
                                          : filteredList.length,
                                      itemBuilder: (context, index) {
                                        ArticleModel article = searchStr.isEmpty
                                            ? articleList[index]
                                            : filteredList[index];
                                        return ShowCategory(
                                          image: article.imageUrl!,
                                          title: article.title!,
                                          desc: article.desc!,
                                          url: article.url!,
                                          toggleTheme: widget.toggleTheme,
                                        );
                                      },
                                    ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 90,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  image: categoryList[index].categoryImage!,
                                  categoryName:
                                      categoryList[index].categoryName!,
                                  toggleTheme: widget.toggleTheme,
                                );
                              }),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Breaking News!!",
                              style: style.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 17),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllNews(
                                          news: "Breaking",
                                          toogleTheme: widget.toggleTheme))),
                              child: Text(
                                "View All",
                                style: style.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider(
                          items: slidersList.map((sliderModel) {
                            return SliderWidget(
                              sliderModel: sliderModel,
                              toogleTheme: widget.toggleTheme,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          )),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: slidersList.length,
                          effect: const ExpandingDotsEffect(
                              dotHeight: 10, dotWidth: 10),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending News!!",
                              style: style.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 17),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllNews(
                                          news: "Trending",
                                          toogleTheme: widget.toggleTheme))),
                              child: Text(
                                "View All",
                                style: style.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.83,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: articleList.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articleList[index].imageUrl!,
                                title: articleList[index].title!,
                                desc: articleList[index].desc!,
                                blogUrl: articleList[index].url!,
                                toogleTheme: widget.toggleTheme,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}
