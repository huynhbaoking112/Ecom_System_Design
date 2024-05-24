import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarCustom extends StatelessWidget {
  double numStar;
  double sizeStar;
  StarCustom({super.key, required this.numStar, this.sizeStar=20});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(rating: numStar,
    itemBuilder: (context, index) => Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: sizeStar,
    direction: Axis.horizontal,);
  }
}