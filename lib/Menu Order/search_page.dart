// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';

class searchPage extends StatefulWidget {
  final String jwtToken;
  final int reservationId;
  final int menuId;
  final int categoryId;
  final bool isCourse;
  const searchPage(
      {super.key,
      required this.menuId,
      required this.categoryId,
      required this.isCourse,
      required this.reservationId,
      required this.jwtToken});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuFood(
                            jwtToken: widget.jwtToken,
                            reservationId: widget.reservationId,
                            isCourse: widget.isCourse,
                            categoryId: widget.categoryId,
                          )),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 30,
              )),
          backgroundColor: Colors.greenAccent,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
