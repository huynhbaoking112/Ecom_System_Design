import 'package:amazon_client/common/widgets/searchBar.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Search/screens/search_screen.dart';
import 'package:amazon_client/features/home/widgets/address_location.dart';
import 'package:amazon_client/features/home/widgets/carousel_item.dart';
import 'package:amazon_client/features/home/widgets/categories.dart';
import 'package:amazon_client/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home-screen";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
      
                //Search Bar
                SearchBarTitle(),
      
                //Delivery to address location
                AddressLocation(),
      
                SizedBox(
                  height: 20,
                ),
      
                //Categories
                CategoriresTop(),
                CarouselItem(),
      
                //Deal of the day
                DealOfTheDay()
              ],
            ),
          )),
    );
  }
}
