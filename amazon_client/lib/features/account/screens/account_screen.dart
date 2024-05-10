import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/account/widgets/below_app_bar.dart';
import 'package:amazon_client/features/account/widgets/top_button.dart';
import 'package:amazon_client/features/account/widgets/your_order.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            // logo amazon
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset("assets/images/amazon_in.png", width: 120, height: 45),
            ),


            //Notification and search
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon notification
                  Icon(Icons.notifications_none_outlined),
                  
                  SizedBox(width: 10,),

                  //Icon search
                  Icon(Icons.search)
                ],
              ),
            )

          ],
        ),

      ),
      ),
      body: Column(
        children: [

          //Below App Bar
          BelowAppBar(),
          const SizedBox(height: 10),

          //All top button
          TopButton(),
          const SizedBox(height: 20,),
          
          //Your order
          YourOrder(),
        ],
      ),
    );
  }
}