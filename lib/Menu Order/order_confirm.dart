// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/order_method.dart';
import 'package:oms_mobile/Menu%20Order/order_method_online.dart';

class orderConfirm extends StatefulWidget {
  final int reservationId;
  final String? orderId;
  const orderConfirm(
      {super.key, required this.orderId, required this.reservationId});

  @override
  State<orderConfirm> createState() => _orderConfirmState();
}

class _orderConfirmState extends State<orderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text("Order",
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homeScreen()),
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
            'Your order has already completed! please choose payment method to continue proceed.',
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
                      color: const Color.fromRGBO(159, 192, 136, 80),
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
                            'Cash',
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
                      color: const Color.fromRGBO(159, 192, 136, 80),
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
                            'Online Method',
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
