import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/account/widgets/top_button.dart';
import 'package:amazon_client/models/user.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    return Container(
      
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),

      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient
      ),

      child: Row(
        children: [
          //Hello and name
          RichText(
            text: TextSpan(text: "Hello, ", style: TextStyle(
              color: Colors.black,
              fontSize: 22
            ),
            children: [
              TextSpan(text: user.name, style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700
            ),)
            ]
            ),
          ),
        ],
      ),
    );
  }
}