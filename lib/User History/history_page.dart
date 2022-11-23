// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/User%20History/history_order_detail.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class historyPage extends StatefulWidget {
  const historyPage({super.key});

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  List<ReservationNoTable>? reservationList;
  List<Order>? orderList;
  var isLoadedOrder = false;
  var isLoadedReservation = false;

  @override
  void initState() {
    super.initState();
    getReservationData();
    getOrderData();
  }

  getReservationData() async {
    reservationList = await RemoteService().getReservationsHistory();
    if (reservationList != null) {
      if (mounted) {
        setState(() {
          isLoadedReservation = true;
        });
      }
    }
  }

  getOrderData() async {
    orderList = await RemoteService().getOrdersHistory();
    if (orderList != null) {
      if (mounted) {
        setState(() {
          isLoadedOrder = true;
        });
      }
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
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('history'.tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoadedOrder,
        replacement: Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getOrderData();
            });
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
            itemCount: orderList?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => historyDetailOrder(
                              orderId: orderList![index].id,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
                                    color: Color.fromRGBO(232, 192, 125, 100),
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
                                      orderList![index].status.tr,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      orderList![index].date.substring(0, 10),
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Deposit money:'.tr} ${changeFormat(orderList![index].prePaid)}đ',
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
                                  '${changeFormat(orderList![index].total)}đ',
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
