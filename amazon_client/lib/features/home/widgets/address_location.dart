import 'package:amazon_client/models/user.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressLocation extends StatefulWidget {
  const AddressLocation({super.key});

  @override
  State<AddressLocation> createState() => _AddressLocationState();
}

class _AddressLocationState extends State<AddressLocation> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          //Icon location
          Icon(Icons.location_on_outlined),

          //Location
          Expanded(
            child: Text(" Delivery  to ${user.name} - ${user.address}", style: TextStyle(
              fontWeight: FontWeight.w500
            ),overflow: TextOverflow.ellipsis,),
          ),

          //Icon drop down
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
               