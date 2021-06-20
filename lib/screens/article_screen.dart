import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  static const String id = 'article_screen';
  final String articleUrl;
  ArticleScreen({required this.articleUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flut',
              style: TextStyle(color: Color(0xff50A3A4)),
            ),
            Text(
              'News',
              style: TextStyle(color: Color(0xffFCAF38)),
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.articleUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
