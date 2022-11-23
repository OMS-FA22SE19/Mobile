// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/order_success.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class orderMethod extends StatefulWidget {
  final String? orderId;
  final String method;
  final int reservationId;

  const orderMethod(
      {super.key,
      required this.orderId,
      required this.method,
      required this.reservationId});

  @override
  State<orderMethod> createState() => _orderMethodState();
}

class _orderMethodState extends State<orderMethod> {
  bool flag = false;
  Order? currentOrder;
  List<OrderDetail>? details;
  var isLoaded = false;
  int total = 0;

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
    flag = currentOrder?.status.contains("Paid") ?? false;
    details = currentOrder?.orderDetails;
    if (currentOrder != null) {
      setState(() {
        isLoaded = true;
        total = (currentOrder?.total ?? 0) + (currentOrder?.prePaid ?? 0);
      });
    }
  }

  checkingOrder() {
    RemoteService().checkingOrder(widget.orderId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text("Order",
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const homeScreen()),
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
                getData();
              },
              icon: const Icon(
                Icons.refresh_rounded,
                size: 30,
              )),
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
                                  'Price: ${details![index].price.toString()}',
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
                                    'Quantity: ${details![index].quantity.toString()}',
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
                  'Payment Method: ${widget.method}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(100),
                            1: FixedColumnWidth(150),
                          },
                          children: <TableRow>[
                            TableRow(children: [
                              Text(
                                'Total bill: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${changeFormat(total)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Deposit: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '- ${changeFormat(currentOrder?.prePaid ?? 0)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Total pay: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${changeFormat(currentOrder?.total ?? 0)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (flag == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orderSuccess(
                                        orderId: widget.orderId ?? "",
                                      )),
                            );
                          } else {
                            checkingOrder();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Remind',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "A staff will come and checked-out the order for you! Please wait and don't push any button!",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('I understand'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(232, 192, 125, 100),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: conditionalButton(),
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

  conditionalButton() {
    if (flag) {
      return Text(
        'Continue',
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.cabin(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      );
    } else {
      return Text(
        'Process',
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.cabin(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      );
    }
  }
}
