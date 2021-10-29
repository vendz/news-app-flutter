import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:news_app/helper/menu_items.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ArticleScreen extends StatefulWidget {
  final String articleUrl;
  ArticleScreen({required this.articleUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int position = 1;
  bool _showConnected = false;
  bool isLightTheme = true;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    getTheme();
  }

  getTheme() async {
    final settings = await Hive.openBox('settings');
    setState(() {
      isLightTheme = settings.get('isLightTheme') ?? false;
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
          content: Text(
            "You are Offline",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (isConnected && _showConnected) {
      _showConnected = false;
      final snackBar = SnackBar(
          content: Text(
            "You are back Online",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: isLightTheme
            ? SystemUiOverlayStyle(statusBarColor: Colors.transparent)
            : SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: Colors.transparent,
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
              'News',
              style: TextStyle(color: Color(0xff50A3A4)),
            ),
            Text(
              'Wipe',
              style: TextStyle(color: Color(0xffFCAF38)),
            ),
            SizedBox(width: 20),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return MenuItems.choices.map((String choice) {
                return PopupMenuItem(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
            onSelected: choiceAction,
          )
        ],
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
              _controller.complete(webViewController);
            }),
          ),
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == MenuItems.Copy) {
      Clipboard.setData(ClipboardData(text: widget.articleUrl));
      Fluttertoast.showToast(
        msg: "Link Copied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    } else if (choice == MenuItems.Open_In_Browser) {
      launch(widget.articleUrl);
    } else if (choice == MenuItems.Share) {
      Share.share(widget.articleUrl);
    }
  }
}
