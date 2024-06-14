import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/vars/globals.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  final Function toggleTheme;

  const ArticleView({
    super.key,
    required this.blogUrl,
    required this.toggleTheme,
  });

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late WebViewController _controller;
  bool loader = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flash",
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.toggleTheme();
              _applyWebViewTheme();
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
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            onPageStarted: (url) {
              setState(() {
                loader = false;
              });
            },
            onPageFinished: (String url) {
              _applyWebViewTheme();
            },
          ),
          loader
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: Colors.blue,
                      rightDotColor: Colors.pink,
                      size: 50,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _applyWebViewTheme() {
    String css = AppTheme.currentTheme.brightness == Brightness.light
        ? '''body { background-color: white; color: black; }'''
        : '''body { background-color: black; color: white; }''';

    _controller.runJavascript('''
      (function() {
        var style = document.createElement('style');
        style.innerHTML = '$css';
        document.head.appendChild(style);
      })();
    ''');
  }
}
