// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class orderMethodOnline extends StatefulWidget {
  final String? orderId;
  final String method;
  final int tableId;
  const orderMethodOnline(
      {super.key, this.orderId, required this.method, required this.tableId});

  @override
  State<orderMethodOnline> createState() => _orderMethodOnlineState();
}

class _orderMethodOnlineState extends State<orderMethodOnline> {
  Orders? currentOrder;
  paymentURL? payment;
  List<OrderDetail>? details;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  getData() async {
    currentOrder = await RemoteService().getOrders(widget.orderId);
    payment = await RemoteService()
        .getPaymentURL(widget.orderId, currentOrder?.total);
    details = currentOrder?.orderDetails;
    if (currentOrder != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

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
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 menuCategory(tableId: widget.tableId)),
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.menu_book_rounded,
          //       size: 30,
          //     )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: details?.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 180,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(232, 192, 125, 100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: 150,
                              child: const Icon(
                                Icons.lunch_dining_rounded,
                                size: 120,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  details![index].foodName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Price: ' + details![index].price.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 18, color: Colors.white),
                                ),
                                // Text(
                                //   'Quantity: ' +
                                //       details![index].quantity.toString(),
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: GoogleFonts.cabin(
                                //       fontSize: 18, color: Colors.white),
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.brown[600],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Quantity:  ' +
                                        details![index].quantity.toString(),
                                    style: GoogleFonts.cabin(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // ignore: sort_child_properties_last
        child: Container(
          height: 120,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Payment Method: ' + widget.method,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
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
                              changeFormat(currentOrder?.total ?? 0),
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
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Test(
                          //             orderId: widget.orderId,
                          //             total: currentOrder?.total,
                          //           )),
                          // );
                          launchUrl(
                            Uri.parse(payment?.url ?? ""),
                            mode: LaunchMode.externalApplication,
                          );
                          closeInAppWebView();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(232, 192, 125, 100),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Pay',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cabin(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
