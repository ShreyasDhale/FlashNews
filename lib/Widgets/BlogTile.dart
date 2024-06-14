import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Pages/ArticleView.dart';
import 'package:news_app/vars/globals.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, blogUrl;
  final Function toogleTheme;
  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.blogUrl,
      required this.toogleTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleView(
                    blogUrl: blogUrl,
                    toggleTheme: toogleTheme,
                  )),
        ),
        child: Card(
          elevation: 8,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: Colors.blue,
                      rightDotColor: Colors.pink,
                      size: 30,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'Assets/Images/placeholder.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: style.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: style.copyWith(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
