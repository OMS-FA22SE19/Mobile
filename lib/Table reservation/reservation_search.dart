// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:get/get.dart';

class searchReservation extends StatefulWidget {
  final String jwtToken;
  const searchReservation({super.key, required this.jwtToken});

  @override
  State<searchReservation> createState() => _searchReservationState();
}

class _searchReservationState extends State<searchReservation> {
  final textController = TextEditingController();

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
                    builder: (context) => homeScreen(
                          jwtToken: widget.jwtToken,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: textController,
              scrollPhysics: const BouncingScrollPhysics(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Input your phone number'.tr,
                  errorText: false ? "This field is empty".tr : null),
            ),
          ),
        ),
      ),
    );
  }
}
