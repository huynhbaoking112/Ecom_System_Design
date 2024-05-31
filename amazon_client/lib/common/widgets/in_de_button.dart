
import 'package:flutter/material.dart';

class InAndDeButton extends StatelessWidget {
  String symbol;
  InAndDeButton({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        // shape:  BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[300]
      ),
      child: Center(child: Text(symbol, style: TextStyle(
        fontSize: 25,
        color: symbol == "-"?Colors.red:Colors.green
      ),)),
    );
  }
}