import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:news_app/components/shimmer_news_tile.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/components/news_tile.dart';
import 'package:news_app/helper/news.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transition/transition.dart';

class HomeScreen extends StatefulWidget {
  final String category;
  HomeScreen({required this.category});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles = [];
  bool _loading = true;
  bool _showConnected = false;
  bool _articleExists = true;
  bool _retryBtnDisabled = false;

  Icon themeIcon = Icon(Icons.dark_mode);
  bool isLightTheme = false;

  Color baseColor = Colors.grey[300]!;
  Color highlightColor = Colors.grey[100]!;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    _loading = true;
    getNews();
    getTheme();
  }

  getTheme() async {
    final settings = await Hive.openBox('settings');
    setState(() {
      isLightTheme = settings.get('isLightTheme') ?? false;
      baseColor = isLightTheme ? Colors.grey[300]! : Color(0xff2c2c2c);
      highlightColor = isLightTheme ? Colors.grey[100]! : Color(0xff373737);
      themeIcon = isLightTheme ? Icon(Icons.dark_mode) : Icon(Icons.light_mode);
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
      getNews();
    }
  }

  getNews() async {
    _loading = true;
    checkConnectivity();
    News newsClass = News();
    await newsClass.getNews(category: widget.category);
    articles = newsClass.news;
    setState(() {
      if (articles.isEmpty) {
        _articleExists = false;
      } else {
        _articleExists = true;
      }
      _loading = false;
      _retryBtnDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              Transition(
                child: CategoryScreen(),
                transitionEffect: TransitionEffect.LEFT_TO_RIGHT,
              ),
            );
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
              'News',
              style: TextStyle(color: Color(0xff50A3A4)),
            ),
            Text(
              'Wipe',
              style: TextStyle(color: Color(0xffFCAF38)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await themeProvider.toggleThemeData();
              setState(() {
                themeIcon = themeProvider.themeIcon();
              });
            },
            icon: themeIcon,
          ),
        ],
      ),
      body: _loading
          ? Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ShimmerNewsTile();
                },
              ),
            )
          : _articleExists
              ? RefreshIndicator(
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
                        fullArticle: articles[index].fullArticle,
                      );
                    },
                  ),
                  onRefresh: () => getNews(),
                )
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No data available"),
                        TextButton(
                          child: Text('Retry Now!'),
                          onPressed: () {
                            if (!_articleExists) {
                              setState(() {
                                _retryBtnDisabled = true;
                              });
                              getNews();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
