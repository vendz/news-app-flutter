import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[300],
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 16,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 16,
                width: (MediaQuery.of(context).size.width) / 4,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 10,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.grey[300],
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
