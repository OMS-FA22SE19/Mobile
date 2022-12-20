// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/order_method_cash.dart';
import 'package:oms_mobile/Menu%20Order/order_method_online.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/services/remote_service.dart';

class orderConfirm extends StatefulWidget {
  final String jwtToken;
  final int reservationId;
  final String? orderId;
  const orderConfirm(
      {super.key,
      required this.orderId,
      required this.reservationId,
      required this.jwtToken});

  @override
  State<orderConfirm> createState() => _orderConfirmState();
}

class _orderConfirmState extends State<orderConfirm> {
  UserProfile? currentUser;
  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            (currentUser?.userName.contains("defaultCustomer") ?? false)
                ? const Color.fromRGBO(232, 192, 125, 100)
                : Colors.blue[600],
        centerTitle: true,
        title: Text('Order'.tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        homeScreen(jwtToken: widget.jwtToken)),
              );
            },
            icon: const Icon(
              Icons.home_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuCategory(
                            jwtToken: widget.jwtToken,
                            reservationId: widget.reservationId,
                          )),
                );
              },
              icon: Icon(
                Icons.menu_book_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.local_dining_rounded,
            size: 150,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your order has already completed! please choose payment method to continue proceed.'
                .tr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cabin(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => orderMethod(
                              jwtToken: widget.jwtToken,
                              reservationId: widget.reservationId,
                              orderId: widget.orderId,
                              method: "Cash",
                            )),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.green,
                child: Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          (currentUser?.userName.contains("defaultCustomer") ??
                                  false)
                              ? const Color.fromRGBO(232, 192, 125, 100)
                              : Colors.blue[600],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_dining_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text(
                            'Cash Method'.tr,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => orderMethodOnline(
                              reservationId: widget.reservationId,
                              jwtToken: widget.jwtToken,
                              tableId: widget.reservationId,
                              orderId: widget.orderId,
                              method: "Online Method",
                            )),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.green,
                child: Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          (currentUser?.userName.contains("defaultCustomer") ??
                                  false)
                              ? const Color.fromRGBO(232, 192, 125, 100)
                              : Colors.blue[600],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_dining_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text(
                            'Online Method'.tr,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          )
        ],
      )),
    );
  }
}
