import 'package:amazon_client/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((e){
        return Builder(builder: (context) => Image.network(e, fit: BoxFit.cover, height: 200,),);
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200));
  }
}