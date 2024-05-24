import 'package:amazon_client/common/widgets/button_custom.dart';
import 'package:amazon_client/common/widgets/star_common.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Search/screens/search_screen.dart';
import 'package:amazon_client/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/productscreen';
  Product product;
  ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar
            Expanded(
              child: Container(
                height: 42,
                margin: EdgeInsets.only(left: 15),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(7),
                  //Search
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: () {
                          if (searchController.text.isNotEmpty) {
                            Navigator.pushNamed(context, SearchScreen.routeName,
                                arguments: searchController.text);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 10),
                      hintText: "Search Amazon.in",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1)),
                    ),
                  ),
                ),
              ),
            ),

            //Icon Mic
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.mic,
                size: 28,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // id and star
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //id
                  Text(widget.product.id.toString()),
                  //star
                  StarCustom(numStar: 4)
                ],
              ),
          
              //Name Product
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 20),
              ),
          
              //Carousel image
              CarouselSlider(
                  items: widget.product.images.map((e) {
                    return Builder(
                      builder: (context) => Image.network(
                        e,
                        fit: BoxFit.fitHeight,
                        height: 320,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(viewportFraction: 1, height: 300)),
          
              //Diliver
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 5,
                color: Colors.black12,
              ),
          
              //Deal Price
              RichText(
                text: TextSpan(text: "Deal Price: ",style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 22), children:[
                  TextSpan(text:"\$"+ widget.product.price.toString(), style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25))
                ])),
          
              const SizedBox(height: 10,),
              //Description
              Text(widget.product.description, style: TextStyle(fontSize: 18),),
        
              //Diliver
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 5,
                color: Colors.black12,
              ),
        
              MyButtonCustom(text: "Buy Now", onPressedButton: (){}),
        
              const SizedBox(height: 35,),
        
              MyButtonCustom(text: "Add to Cart",textColor: Colors.black , color: Colors.yellow.shade600,onPressedButton: (){}),
        
              
              //Diliver
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 5,
                color: Colors.black12,
              ),

              //Rate the Product
              Text("Rate The Product", style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              
              RatingBar.builder(
                direction: Axis.horizontal,
                initialRating: 1,
                itemCount: 5,
                allowHalfRating: true,
                itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber,), onRatingUpdate: (ratings){

                })
              
            ],
          ),
        ),
      ),
    );
  }
}
