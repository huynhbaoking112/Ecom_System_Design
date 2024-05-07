import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/auth/screens/auth_screen.dart';
import 'package:amazon_client/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Amazon",
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
         appBarTheme:const  AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        ),
        
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: AuthScreen()
    );
  }
}