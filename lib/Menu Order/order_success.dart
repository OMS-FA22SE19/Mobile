// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/services/remote_service.dart';

class orderSuccess extends StatefulWidget {
  const orderSuccess({super.key, required this.orderId});
  final String orderId;

  @override
  State<orderSuccess> createState() => _orderSuccessState();
}

class _orderSuccessState extends State<orderSuccess> {
  Order? currentOrder;
  List<OrderDetail>? details;
  var isLoaded = false;
  bool flag = false;
  int count = 0;
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
        leading: null,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Visibility(
            visible: isLoaded,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.table_restaurant_rounded,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Order Information',
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(170),
                          2: FlexColumnWidth(),
                        },
                        children: <TableRow>[
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Date:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentOrder?.date.substring(0, 10) ?? "",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Status:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentOrder?.status ?? "",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Total bill:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${changeFormat(total)} đ',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Pre paid:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${changeFormat(currentOrder?.prePaid ?? 0)} đ',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Total paid:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${changeFormat(currentOrder?.total ?? 0)} đ',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          const TableRow(children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'User: ',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'User Default',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Phone: ',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0941767748',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const reservationList()),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Text(
                            'Back to home',
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
