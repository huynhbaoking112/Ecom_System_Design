import 'package:amazon_client/features/home/screens/bottom_navigation_bar.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Admin/screens/admin_screen.dart';
import 'package:amazon_client/features/auth/screens/auth_screen.dart';
import 'package:amazon_client/features/auth/services/auth_service.dart';
import 'package:amazon_client/providers/cart_provider.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:amazon_client/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(create: (context) =>  CartProvider(),)
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Amazon",
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: StartScreen());
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).user.token.isNotEmpty
        ? Provider.of<UserProvider>(context).user.type == "user"
            ? BottomBar()
            : AdminScreen()
        : AuthScreen();
  }
}
