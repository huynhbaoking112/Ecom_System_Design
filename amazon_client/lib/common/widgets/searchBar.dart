import 'dart:async';

import 'package:amazon_client/common/services/searchIndex.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Search/screens/search_screen.dart';
import 'package:amazon_client/models/product.dart';
import 'package:flutter/material.dart';

class SearchBarTitle extends StatefulWidget {
  const SearchBarTitle({super.key});

  @override
  State<SearchBarTitle> createState() => _SearchBarTitleState();
}

class _SearchBarTitleState extends State<SearchBarTitle> {
  List<Product> allSearchSuggest = [];
  TextEditingController searchController = TextEditingController();

  //Kỹ thuật debounce
  Timer? _debounce;

  //Goị API
  void _handleSearch(String text) async {
    allSearchSuggest = await SearchBarService.searchProductBar(
        searchKey: text, context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: Column(
        children: [
          Row(
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
                      onChanged: (value) {
                        _debounce?.cancel();
                        if (searchController.text.isNotEmpty) {
                          _debounce = Timer(Duration(microseconds: 100), () {
                            _handleSearch(value);
                          });
                        } else {
                          setState(() {
                            allSearchSuggest = [];
                          });
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {
                            if (searchController.text.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, SearchScreen.routeName,
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
          allSearchSuggest.isNotEmpty
              ? Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: allSearchSuggest.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SearchScreen.routeName,
                              arguments: allSearchSuggest[index].name);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 17, right: 40),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black12))),
                          height: 30,
                          width: double.infinity,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                allSearchSuggest![index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              )),
                        ),
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
