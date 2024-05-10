import 'package:amazon_client/constants/global_variables.dart';
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
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Search Bar
                Expanded(
                  child: Container(
                    height: 42,
                    margin: EdgeInsets.only(left: 15),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(7),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(top: 10),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                        ),
                      ),
                    ),
                  ),
                ),

                //Icon Mic
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.mic,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
          
              //Delivery to address location
              AddressLocation(),
          
              SizedBox(height: 20,),
          
              //Categories 
              CategoriresTop(),
              CarouselItem(),
          
              //Deal of the day
              DealOfTheDay()
          
            ],
          ),
        ));
  }
}
 