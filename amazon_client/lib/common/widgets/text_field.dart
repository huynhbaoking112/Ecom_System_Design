// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amazon_client/constants/global_variables.dart';

class TextFieldCustom extends StatelessWidget {


  final TextEditingController controllerText;
  final String hintText;
  final bool pass;
  final String? Function(String?)? validator;
  final int maxLines;

  const TextFieldCustom({
    Key? key,       
    required this.controllerText,
    required this.hintText,
    required this.pass,                       
    required this.validator,
    this.maxLines = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        constraints: BoxConstraints(minHeight: 50, minWidth: double.infinity),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.green.shade600,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade800,
          )
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red.shade800,
          )
        ),      
      ),
      obscureText: pass,
      validator:validator,
    );
  }
}
