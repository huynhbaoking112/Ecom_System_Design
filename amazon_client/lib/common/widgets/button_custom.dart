import 'package:amazon_client/constants/global_variables.dart';
import 'package:flutter/material.dart';

class MyButtonCustom extends StatelessWidget {

  final String text;
  final Function onPressedButton;
  final Color color;
  final Color textColor;
  const MyButtonCustom({super.key, required this.text,this.textColor = Colors.white ,required this.onPressedButton, this.color=GlobalVariables.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 50),
        foregroundColor: textColor,
        backgroundColor: color
      ),
      onPressed: (){
        onPressedButton();
      },
      child: Text(text),
    );
  }
}