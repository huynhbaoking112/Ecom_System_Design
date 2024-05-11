import 'package:amazon_client/features/Admin/screens/add_product_screen.dart';
import 'package:amazon_client/features/Admin/screens/admin_screen.dart';
import 'package:amazon_client/features/auth/screens/auth_screen.dart';
import 'package:amazon_client/common/widgets/bottom_screen.dart';
import 'package:amazon_client/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => AuthScreen(),);
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