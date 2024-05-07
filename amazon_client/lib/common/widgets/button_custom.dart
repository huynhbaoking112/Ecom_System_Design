import 'package:amazon_client/constants/global_variables.dart';
import 'package:flutter/material.dart';

class MyButtonCustom extends StatelessWidget {

  final String text;
  final Function onPressedButton;

  const MyButtonCustom({super.key, required this.text, required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 50),
        foregroundColor: Colors.white,
        backgroundColor: GlobalVariables.secondaryColor
      ),
      onPressed: (){
        onPressedButton();
      },
      child: Text(text),
    );
  }
}