import 'package:amazon_client/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CategoriresTop extends StatefulWidget {
  const CategoriresTop({super.key});

  @override
  State<CategoriresTop> createState() => _CategoriresTopState();
}

class _CategoriresTopState extends State<CategoriresTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
           itemExtent: 80,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return  Container(
            child: Column(
              children: [

                //Image
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset(GlobalVariables.categoryImages[index]["image"]!, fit: BoxFit.cover, height: 50, width: 50,)),
                ),

                SizedBox(height: 10,),

                //Title
                Text(GlobalVariables.categoryImages[index]['title']!, style: TextStyle(

                ),),
              ],
            ),
          );
        },
      ),
    );
  }
}