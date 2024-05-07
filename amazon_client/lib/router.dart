import 'package:amazon_client/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => AuthScreen(),);
    default: 
      return MaterialPageRoute(builder: (context) => Scaffold(
        body: Center(child: Text("Screen does not exist!"),),
      ),);
  }
}