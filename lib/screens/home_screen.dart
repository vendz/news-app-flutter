import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loading = true;
    getNews();
  }

  getNews() async {
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
            Text('Inquirer'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
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
                  }),
              onRefresh: () => getNews(),
            ),
    );
  }
}
