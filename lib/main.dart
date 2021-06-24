import 'package:flutter/material.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(category: 'all'),
        ArticleScreen.id: (context) => ArticleScreen(articleUrl: ''),
        CategoryScreen.id: (context) => CategoryScreen(category: 'all'),
      },
    );
  }
}
