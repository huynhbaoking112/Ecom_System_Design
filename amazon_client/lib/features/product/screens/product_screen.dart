import 'package:amazon_client/common/widgets/button_custom.dart';
import 'package:amazon_client/common/widgets/searchBar.dart';
import 'package:amazon_client/common/widgets/star_common.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Search/screens/search_screen.dart';
import 'package:amazon_client/features/product/service/product_service.dart';
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
  ProductService _productService = ProductService();
  double rating = 1;

//Pull Rating of product
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRating();
  }

  getRating() async {
    rating = await _productService.getRatingProduct(
        context: context, productId: widget.product.id.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search Bar
              SearchBarTitle(),

              //Product
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        StarCustom(numStar: rating)
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
                        options:
                            CarouselOptions(viewportFraction: 1, height: 300)),
                
                    //Diliver
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 5,
                      color: Colors.black12,
                    ),
                
                    //Deal Price
                    RichText(
                        text: TextSpan(
                            text: "Deal Price: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 22),
                            children: [
                          TextSpan(
                              text: "\$" + widget.product.price.toString(),
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent, fontSize: 25))
                        ])),
                
                    const SizedBox(
                      height: 10,
                    ),
                    //Description
                    Text(
                      widget.product.description,
                      style: TextStyle(fontSize: 18),
                    ),
                
                    //Diliver
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 5,
                      color: Colors.black12,
                    ),
                
                    MyButtonCustom(text: "Buy Now", onPressedButton: () {}),
                
                    const SizedBox(
                      height: 35,
                    ),
                
                    MyButtonCustom(
                        text: "Add to Cart",
                        textColor: Colors.black,
                        color: Colors.yellow.shade600,
                        onPressedButton: () {
                          ProductService.addProductInCart(context: context, productId: widget.product.id!, quantity: 1);
                        }),
                
                    //Diliver
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 5,
                      color: Colors.black12,
                    ),
                
                    //Rate the Product
                    Text(
                      "Rate The Product",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                
                    RatingBar.builder(
                        direction: Axis.horizontal,
                        initialRating: rating,
                        itemCount: 5,
                        allowHalfRating: true,
                        itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (ratings) {
                          _productService.setRatingProduct(
                              context: context,
                              productId: widget.product.id.toString(),
                              rating: ratings);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
