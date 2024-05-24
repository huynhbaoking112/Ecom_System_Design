import 'package:amazon_client/features/Admin/screens/add_product_screen.dart';
import 'package:amazon_client/features/Admin/screens/admin_screen.dart';
import 'package:amazon_client/features/Search/screens/search_screen.dart';
import 'package:amazon_client/features/auth/screens/auth_screen.dart';
import 'package:amazon_client/features/home/screens/bottom_navigation_bar.dart';
import 'package:amazon_client/features/home/screens/category_deal.dart';
import 'package:amazon_client/features/home/screens/home_screen.dart';
import 'package:amazon_client/features/product/screens/product_screen.dart';
import 'package:amazon_client/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: (context) => SearchScreen(searchKey: routeSettings.arguments.toString(),),);
    case ProductScreen.routeName:
      return MaterialPageRoute(builder: (context) => ProductScreen(product: routeSettings.arguments as Product),);
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => AuthScreen(),);
    case CategoryDeal.routeName:
      return MaterialPageRoute(builder: (context) => CategoryDeal(category: routeSettings.arguments.toString()),);
    case AdminScreen.routeName:
      return MaterialPageRoute(builder: (context) => AdminScreen(),);
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (context) => AddProductScreen(),);
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (context) => BottomBar(),);
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => HomePage(),);
    default: 
      return MaterialPageRoute(builder: (context) => Scaffold(
        body: Center(child: Text("Screen does not exist!"),),
      ),);
  }
}