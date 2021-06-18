import 'package:flutter/material.dart';
import 'package:news_app/components/category_card.dart';
import 'package:news_app/helper/categoryData.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/screens/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category_screen';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
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
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text('Categories'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CategoryCard(
                image: categories[index].imageAssetUrl,
                text: categories[index].categoryName,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contxt) =>
                            HomeScreen(category: categories[index].category)));
              },
            );
          },
        ),
      ),
    );
  }
}
