import 'package:flutter/material.dart';
import 'package:news_app/screens/article_screen.dart';

class NewsTile extends StatelessWidget {
  final String image, title, content, date, views, fullArticle;
  NewsTile({
    required this.content,
    required this.date,
    required this.image,
    required this.title,
    required this.views,
    required this.fullArticle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    image,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                content,
                maxLines: 2,
                style: TextStyle(
                  // color: isLightTheme ? Colors.black54 : Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 15.0,
                      ),
                      Text(
                        views,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleScreen(articleUrl: fullArticle)));
      },
    );
  }
}
