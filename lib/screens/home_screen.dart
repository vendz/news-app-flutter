import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/shimmer_news_tile.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/components/news_tile.dart';
import 'package:news_app/helper/news.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final String category;
  HomeScreen({required this.category});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles = [];
  bool _loading = true;
  bool _showConnected = false;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    _loading = true;
    getNews();
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

  getNews() async {
    checkConnectivity();
    News newsClass = News();
    await newsClass.getNews(category: widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CategoryScreen.id);
          },
          icon: Icon(
            Icons.amp_stories_outlined,
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
      body: _loading
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ShimmerNewsTile();
              },
            )
          : RefreshIndicator(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsTile(
                    image: articles[index].image,
                    title: articles[index].title,
                    content: articles[index].content,
                    date: articles[index].publishedDate,
                    views: articles[index].views,
                    fullArticle: articles[index].fullArticle,
                  );
                },
              ),
              onRefresh: () => getNews(),
            ),
    );
  }
}
