import 'package:amazon_client/common/widgets/button_custom.dart';
import 'package:amazon_client/common/widgets/searchBar.dart';
import 'package:amazon_client/common/widgets/star_common.dart';
import 'package:amazon_client/features/cart/services/cart_service.dart';
import 'package:amazon_client/features/home/widgets/address_location.dart';
import 'package:amazon_client/common/widgets/in_de_button.dart';
import 'package:amazon_client/models/product.dart';
import 'package:amazon_client/providers/cart_provider.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartService.getInFor(context: context);
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
        double sum =0 ;
        cartProvider.catProduct.allProduct.map((e)=>sum+=e['quantity']*e["product_id"]["price"] as int ).toList();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          SearchBarTitle(),

          //Address
          AddressLocation(),

          //Subtotal
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                  text: "Subtotal",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: [
                    TextSpan(
                        text: " \$" + sum.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25)),
                  ]),
            ),
          ),

          //Button Process
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButtonCustom(
              text: "Process to Buy",
              onPressedButton: () {},
              color: Colors.yellow.shade600,
              textColor: Colors.black,
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 260, mainAxisSpacing: 10, crossAxisCount: 1),
              itemCount: cartProvider.catProduct.allProduct!.length,
              itemBuilder: (context, index) {
                Product product = Product.fromMap(cartProvider.catProduct
                    .allProduct![index]['product_id'] );
                return Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/productscreen",
                          arguments: product);
                    },
                    child: Row(
                      children: [
                        //Image
                        Container(
                          height: double.infinity,
                          child: Image.network(
                            product.images[0],
                            width: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        //Infor
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Name and select
                            Row(
                              children: [
                                // Name
                                Text(product.name,
                                    style: TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //Increment and Decrement Counter
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Decrement
                                GestureDetector(
                                    onTap: () {
                                       setState(() {
                                        CartService.inAndDeProduct(context: context, productId: product.id!, symbol: "-");
                                      });
                                    },
                                    child: InAndDeButton(symbol: "-")),
                                const SizedBox(
                                  width: 20,
                                ),

                                AnimatedFlipCounter(
                                  duration: Duration(milliseconds: 500),
                                  value: cartProvider.catProduct
                                      .allProduct![index]['quantity'] as int,
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepOrangeAccent),
                                ),

                                //Increment
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                        setState(() {
                                          CartService.inAndDeProduct(context: context, productId: product.id!, symbol: "+");
                                        });
                                    },
                                    child: InAndDeButton(symbol: "+")),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            //price
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //Eligble for FREE Shipping
                            Text("Eligible for FREE Shipping"),

                            const SizedBox(
                              height: 10,
                            ),

                            //Delete button
                            ElevatedButton(
                                onPressed: () {
                                  CartService.deleteProduct(context: context, productId:product.id! );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Text("Delete"))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
