import 'package:amazon_client/features/account/services/account_service.dart';
import 'package:amazon_client/features/account/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const  TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //Yours Orders and Turn Seller
        Row(
          children: [
            ButtonWidget(text: "Yours Orders", onTap: (){}),
            ButtonWidget(text: "Turn Seller", onTap: (){}),
          ],
        ),

        //Log Out and Your Wish List
        Row(
          children: [
            ButtonWidget(text: "Log Out", onTap: (){
              AccountService.signOutUser(context: context);
            }),
            ButtonWidget(text: "Your Wish List", onTap: (){}),
          ],
        )


      ],
    );
  }
}