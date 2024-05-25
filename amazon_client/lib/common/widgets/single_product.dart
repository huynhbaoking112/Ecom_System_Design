// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String url;
  const SingleProduct({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                // margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5)
                ),
                width: 180,
                height: 170,
                child: Container(
                  child: Image.network(url, fit: BoxFit.fitHeight,),
                ),
              );;
  }
}
