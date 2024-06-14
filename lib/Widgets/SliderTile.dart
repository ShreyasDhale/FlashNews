import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Models/slider.dart';
import 'package:news_app/Pages/ArticleView.dart';
import 'package:news_app/vars/globals.dart';

class SliderWidget extends StatelessWidget {
  final SliderModel sliderModel;
  final Function toogleTheme;
  const SliderWidget({
    super.key,
    required this.sliderModel,
    required this.toogleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleView(
                  blogUrl: sliderModel.url!, toggleTheme: toogleTheme))),
      child: Builder(
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
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
                      fit: BoxFit.cover,
                    ),
                    imageUrl: sliderModel.imageUrl!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 100,
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    sliderModel.title!,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
