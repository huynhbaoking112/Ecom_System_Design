import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Deal of the day
        Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "F⚡ASH SALE",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.orange.shade900),
            )),

        const SizedBox(
          height: 10,
        ),

        //Image product
        Image.network(
          "https://i.pinimg.com/236x/1f/af/2a/1faf2a42d3c7b46ced2b270416915249.jpg",
          height: 235,
          fit: BoxFit.fitHeight,
        ),

        const SizedBox(
          height: 10,
        ),

        //Name Product
        Container(
            padding: EdgeInsets.only(top: 5, left: 20),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.orange, width: 1.5))),
            child: Text(
              "Apple Macbook",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.orange.shade900),
            )),

        const SizedBox(
          height: 5,
        ),

        //Price
        Container(
          decoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.orange, width: 1.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 5, left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\$ 999.0",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: Colors.orange.shade900),
                  )),

              //Star
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        //Carousel Product details
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
               decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.orange, width: 1.5))),
              // padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    "https://i.pinimg.com/236x/ad/ca/90/adca903c597abe4a881fb63e37c5c34b.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  Image.network(
                    "https://i.pinimg.com/236x/ad/ca/90/adca903c597abe4a881fb63e37c5c34b.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  Image.network(
                    "https://i.pinimg.com/236x/ad/ca/90/adca903c597abe4a881fb63e37c5c34b.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  Image.network(
                    "https://i.pinimg.com/236x/ad/ca/90/adca903c597abe4a881fb63e37c5c34b.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  Image.network(
                    "https://i.pinimg.com/236x/ad/ca/90/adca903c597abe4a881fb63e37c5c34b.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            )),

        const SizedBox(
          height: 10,
        ),

        //See all deals
        Container(
            padding: EdgeInsets.only(top: 5, left: 20),
            alignment: Alignment.topLeft,
            child: Text(
              "See all deals...",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            )),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
