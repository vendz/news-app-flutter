import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/category_card.dart';
import 'package:news_app/helper/categoryData.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/screens/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  CategoryScreen({required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];
  bool _showConnected = false;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contxt) => HomeScreen(category: widget.category),
              ),
            );
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contxt) =>
                        HomeScreen(category: categories[index].category),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
