import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Admin/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;


class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {


  //index page
  int indexPage = 0;

  //All Page
  List<Widget> allPage = [
    PostPage(),
    Center(
      child: Text("analyst"),
    ),
    Center(
      child: Text("bag"),
    ),
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
                  child: Icon(Icons.analytics_outlined)),
              label: ""),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      indexPage = 2;
                    });
                  },
                  child: Icon(Icons.badge_outlined)),
              label: ""),
        ],
      ),
      body: allPage[indexPage],

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // logo amazon
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/amazon_in.png",
                    width: 120, height: 45),
              ),

              //Admin text
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Admin", style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
