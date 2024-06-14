import 'package:flutter/material.dart';
import 'package:news_app/Pages/category_news.dart';
import 'package:news_app/vars/globals.dart';

class CategoryTile extends StatelessWidget {
  final String image, categoryName;
  final Function toggleTheme;
  const CategoryTile(
      {super.key,
      required this.toggleTheme,
      required this.image,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    toggleTheme: toggleTheme, name: categoryName))),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.5)),
              child: Center(
                child: Text(
                  categoryName,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
