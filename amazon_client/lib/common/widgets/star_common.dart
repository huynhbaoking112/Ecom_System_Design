import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarCustom extends StatelessWidget {
  double numStar;
  StarCustom({super.key, required this.numStar});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(rating: numStar,
    itemBuilder: (context, index) => Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 20.0,
    direction: Axis.horizontal,);
  }
}