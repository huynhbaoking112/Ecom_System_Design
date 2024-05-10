import 'package:amazon_client/features/Admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductScreen.routeName);
          },
          child: Icon(Icons.add, size:30,),
          backgroundColor: Colors.teal[300],
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          tooltip: 'Add a Product',
        ),
      ),
    );
  }
}
