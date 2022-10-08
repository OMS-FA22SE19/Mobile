// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';
import 'package:oms_mobile/Menu%20Order/menu_status.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuCart extends StatefulWidget {
  final int categoryId;
  final List<food>? foods;
  const menuCart({super.key, required this.foods, required this.categoryId});

  @override
  State<menuCart> createState() => _menuCartState();
}

class _menuCartState extends State<menuCart> {
  int total = 0;
  var isLoaded = true;
  order? newOrder;

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  void initState() {
    totalMoney();
    super.initState();
  }

  void totalMoney() {
    setState(() {
      widget.foods?.forEach((element) {
        total = total + element.price * element.quantity;
      });
      int totalQuantity = 0;
      widget.foods?.forEach((element) {
        totalQuantity = totalQuantity + element.quantity;
      });

      if (totalQuantity == 0) {
        isLoaded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text('Cart',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => menuFood(
                          categoryId: widget.categoryId,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => menuStatus(
        //                     orderId: newOrder?.id,
        //                   )),
        //         );
        //       },
        //       icon: Icon(
        //         Icons.timer_rounded,
        //         size: 30,
        //       )),
        // ],
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoaded,
        replacement:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Your cart is empty. Please add some foods!",
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        child: ListView.builder(
          itemCount: widget.foods?.length,
          itemBuilder: (context, index) {
            if (widget.foods![index].quantity != 0) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.foods![index].name,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Price: ' +
                                          changeFormat(
                                              widget.foods![index].price),
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.foods![index].quantity =
                                          widget.foods![index].quantity - 1;
                                      if (widget.foods![index].quantity < 0)
                                        widget.foods![index].quantity = 0;
                                    });
                                    total = 0;
                                    totalMoney();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.greenAccent,
                                    ),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  widget.foods![index].quantity.toString(),
                                  style: GoogleFonts.bebasNeue(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.foods![index].quantity =
                                          widget.foods![index].quantity + 1;
                                      if (widget.foods![index].quantity > 10)
                                        widget.foods![index].quantity = 10;
                                    });
                                    total = 0;
                                    totalMoney();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.greenAccent,
                                    ),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 10,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // ignore: sort_child_properties_last
        child: Container(
          height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Total: ',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          changeFormat(total),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      newOrder =
                          await RemoteService().createOrder(1, widget.foods);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => menuStatus(
                                  orderId: newOrder?.id,
                                )),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'CONFIRM',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  conditionalWidget(int index) {}
}
