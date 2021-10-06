import 'package:flutter/material.dart';

class ShimmerNewsTile extends StatefulWidget {
  @override
  _ShimmerNewsTileState createState() => _ShimmerNewsTileState();
}

class _ShimmerNewsTileState extends State<ShimmerNewsTile> {
  bool isLightTheme = true;
  Color baseColor = Colors.grey[300]!;
  Color highlightColor = Colors.grey[100]!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[300],
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 16,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 16,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 16,
              width: (MediaQuery.of(context).size.width) / 3,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10,
                  width: 30,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.grey[300],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
