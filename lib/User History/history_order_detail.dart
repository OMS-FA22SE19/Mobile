// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class historyDetailOrder extends StatefulWidget {
  final String orderId;
  const historyDetailOrder({super.key, required this.orderId});

  @override
  State<historyDetailOrder> createState() => _historyDetailOrderState();
}

class _historyDetailOrderState extends State<historyDetailOrder> {
  Order? currentOrder;
  var isloaded = false;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    currentOrder = await RemoteService().getOrder(widget.orderId);
    if (currentOrder != null) {
      setState(() {
        isloaded = true;
        total = currentOrder!.prePaid + currentOrder!.total;
      });
    }
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(currentOrder?.date ?? "",
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => historyPage()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(children: [
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.restaurant_menu_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              currentOrder?.status ?? "",
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
                ]),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: 20,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
        //   child: Container(
        //     width: MediaQuery.of(context).size.width - 20,
        //     // height: 100,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.grey[200],
        //     ),
        //     child: Text(
        //       'Order Detail',
        //       style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
        //     ),
        //   ),
        // ),
        SingleChildScrollView(
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Order Detail',
              style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
            ),
            subtitle: Text(
              'Food list',
              style: GoogleFonts.cabin(fontSize: 15, color: Colors.black),
            ),
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentOrder?.orderDetails.length,
                    itemBuilder: (context, index) {
                      return
                          // ListTile(
                          //   title: Text(
                          //     // reservation?.reservationTables
                          //     //         .elementAt(index)
                          //     //         .tableId
                          //     //         .toString() ??
                          //     currentOrder?.date ?? "",
                          //     style:
                          //         GoogleFonts.cabin(fontSize: 15, color: Colors.black),
                          //   ),
                          // );

                          Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.restaurant_menu_rounded,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentOrder?.orderDetails
                                              .elementAt(index)
                                              .foodName ??
                                          "",
                                      style: GoogleFonts.cabin(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Amount: ${currentOrder?.orderDetails.elementAt(index).quantity}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Status: ${currentOrder?.orderDetails.elementAt(index).status}',
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
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${changeFormat(currentOrder?.orderDetails.elementAt(index).amount ?? 0)} đ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.cabin(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        // Visibility(
        //   visible: isloaded,
        //   replacement: Center(child: CircularProgressIndicator()),
        //   child: Container(
        //     child: ListView.builder(
        //       physics: BouncingScrollPhysics(),
        //       // scrollDirection: Axis.horizontal,
        //       itemCount: currentOrder?.orderDetails.length,
        //       itemBuilder: (context, index) {
        //         return Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Row(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(5.0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         shape: BoxShape.circle,
        //                         color: Colors.greenAccent,
        //                       ),
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(10.0),
        //                         child: Icon(
        //                           Icons.restaurant_menu_rounded,
        //                           size: 30,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(10.0),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           'Com Tam',
        //                           style: GoogleFonts.cabin(
        //                               fontSize: 18,
        //                               fontWeight: FontWeight.bold,
        //                               color: Colors.black),
        //                         ),
        //                         Text(
        //                           'Amount: X 2',
        //                           style: GoogleFonts.roboto(
        //                               fontSize: 15,
        //                               fontWeight: FontWeight.normal,
        //                               color: Colors.black),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Flexible(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   crossAxisAlignment: CrossAxisAlignment.end,
        //                   children: [
        //                     Text(
        //                       '10.000.000₫',
        //                       overflow: TextOverflow.ellipsis,
        //                       maxLines: 2,
        //                       style: GoogleFonts.cabin(
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.black),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ]);
        //       },
        //     ),
        //   ),
        // ),
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bill money',
                        style: GoogleFonts.cabin(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${changeFormat(total)} đ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.cabin(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit Money',
                        style: GoogleFonts.cabin(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '- ${changeFormat(currentOrder?.prePaid ?? 0)} đ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.cabin(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.cabin(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${changeFormat(currentOrder?.total ?? 0)} đ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.cabin(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
