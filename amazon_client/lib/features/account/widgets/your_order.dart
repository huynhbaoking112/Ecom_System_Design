import 'package:amazon_client/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class YourOrder extends StatefulWidget {
  const YourOrder({super.key});

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {

  List<String> allProducts = [
    "https://i.pinimg.com/564x/ce/56/2d/ce562d1cc7b5e29c71e33f001189f9d0.jpg",
    "https://i.pinimg.com/236x/b5/44/b7/b544b7fa9bea2ee24c9e55e00d727d71.jpg",
    "https://i.pinimg.com/236x/9f/5d/a6/9f5da67f11964b9780d80da6a75d9a4e.jpg",
    "https://i.pinimg.com/474x/53/2a/0d/532a0da115987ad04c101d25016652ea.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // title your order and see all
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(padding: EdgeInsets.only(left: 15) ,child: Text("Your Orders", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),)),
            Container(padding: EdgeInsets.only(right: 15),child: Text('See all', style: TextStyle(
              color: GlobalVariables.selectedNavBarColor,
              fontSize: 16
            ),))
          ],
        ),

        const SizedBox(height: 10,),

        // Product
        Container(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allProducts.length,
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5)
                ),
                width: 180,
                height: 170,
                child: Container(
                  child: Image.network(allProducts[index], fit: BoxFit.fitHeight,),
                ),
              );
            },
          ),
        )      
  
      ],
    );
  }
}