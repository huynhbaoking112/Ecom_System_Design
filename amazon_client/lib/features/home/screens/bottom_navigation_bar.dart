import 'package:amazon_client/features/account/screens/account_screen.dart';
import 'package:amazon_client/features/cart/screens/cart_user.dart';
import 'package:amazon_client/features/home/screens/home_screen.dart';
import 'package:amazon_client/features/home/service/home_services.dart';
import 'package:amazon_client/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/bottom-screen";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeService.getProductInCart(context: context);
  }

  //index page
  int indexPage = 0;

  //All Page
  List<Widget> allPage = [
    HomePage(),
    AccountScreen(),
    MyCart()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey.shade300,
        elevation: 10,
        currentIndex: indexPage,
        iconSize: 32,
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      indexPage = 0;
                    });
                  },
                  child: Icon(Icons.home)),
              label: ""),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      indexPage = 1;
                    });
                  },
                  child: Icon(Icons.person)),
              label: ""),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      indexPage = 2;
                    });
                  },
                  child: badges.Badge(
                    badgeContent: Text(Provider.of<CartProvider>(context, listen: true).catProduct.allProduct.length.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 15),),
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent,),
                    position: badges.BadgePosition.topEnd(),
                    child: Icon(Icons.shopping_cart_outlined, ),
                  )),
              label: ""),
        ],
      ),
      body: allPage[indexPage],
    );
  }
}
