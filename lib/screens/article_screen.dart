import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String articleUrl;
  ArticleScreen({required this.articleUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  int position = 1;
  bool _showConnected = false;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
  }

  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    var isConnected = result != ConnectivityResult.none;
    if (!isConnected) {
      _showConnected = true;
      final snackBar = SnackBar(
          content: Text("You are Offline"), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (isConnected && _showConnected) {
      _showConnected = false;
      final snackBar = SnackBar(
          content: Text("You are back Online"), backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
      body: IndexedStack(
        index: position,
        children: [
          WebView(
            initialUrl: widget.articleUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (value) {
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (value) {
              setState(() {
                position = 0;
              });
            },
            onWebViewCreated: ((WebViewController webViewController) {
              _completer.complete(webViewController);
            }),
          ),
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
