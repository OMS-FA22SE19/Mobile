// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class historyDetailReservation extends StatefulWidget {
  final String jwtToken;
  final int reservationId;
  const historyDetailReservation(
      {super.key, required this.reservationId, required this.jwtToken});

  @override
  State<historyDetailReservation> createState() =>
      _historyDetailReservationState();
}

class _historyDetailReservationState extends State<historyDetailReservation> {
  // Order? currentOrder;
  ReservationNoTable? currentReservation;
  var isloaded = false;
  // int total = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    currentReservation = await RemoteService()
        .getReservationCancelled(widget.reservationId, widget.jwtToken);
    if (currentReservation != null) {
      setState(() {
        isloaded = true;
        // total = currentOrder!.prePaid + currentOrder!.total;
      });
    }
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  int charge(int? prepaid, int? seats) {
    return ((prepaid ?? 0) / (seats ?? 0)).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (currentReservation?.status.contains("Done") ?? false)
            ? Colors.greenAccent
            : (currentReservation?.status.contains("Processing") ?? false)
                ? Colors.yellow[600]
                : Colors.redAccent,
        centerTitle: true,
        title: Text(
            '${currentReservation?.startTime.toString().substring(0, 10)} | ${currentReservation?.startTime.toString().substring(11, 16)}',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        historyPage(jwtToken: widget.jwtToken)),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getData();
          });
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: ListView(children: [
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
                              color: (currentReservation?.status
                                          .contains("Paid") ??
                                      false)
                                  ? Colors.greenAccent
                                  : (currentReservation?.status
                                              .contains("Processing") ??
                                          false)
                                      ? Colors.yellow[600]
                                      : Colors.redAccent,
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
                                'status'.tr,
                                style: GoogleFonts.cabin(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                currentReservation?.status.tr ?? "",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 100,
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'Cancel Reason'.tr}:',
                        style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                '${currentReservation?.reasonForCancel}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width,
            height: 20,
          ),
          SingleChildScrollView(
            child: ExpansionTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Reservation detail'.tr,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                'Table information'.tr,
                style: GoogleFonts.cabin(fontSize: 15, color: Colors.black),
              ),
              children: [
                SafeArea(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // itemCount: currentReservation?.reservationTables.length,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (currentReservation?.status
                                                .contains("Paid") ??
                                            false)
                                        ? Colors.greenAccent
                                        : (currentReservation?.status
                                                    .contains("Processing") ??
                                                false)
                                            ? Colors.yellow[600]
                                            : Colors.redAccent,
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
                                    // Text(
                                    //   'ID: ${currentReservation?.reservationTables.elementAt(index).table.id}',
                                    //   style: GoogleFonts.cabin(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.black),
                                    // ),
                                    Text(
                                      '${'Type'.tr}: ${currentReservation?.tableType}',
                                      style: GoogleFonts.cabin(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Number of people'.tr}: ${currentReservation?.numOfPeople}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Number of seats'.tr}: ${currentReservation?.numOfSeats}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Charge per seats'.tr}: ${changeFormat(charge(currentReservation?.prePaid, currentReservation?.numOfSeats))} đ',
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
                          // Flexible(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: [
                          //       // Text(
                          //       //   '${changeFormat((currentReservation?.reservationTables.elementAt(index).table.tableType.chargePerSeat ?? 0) * (currentReservation?.numOfSeats ?? 0))} đ',
                          //       //   overflow: TextOverflow.ellipsis,
                          //       //   maxLines: 2,
                          //       //   style: GoogleFonts.cabin(
                          //       //       fontSize: 18,
                          //       //       fontWeight: FontWeight.bold,
                          //       //       color: Colors.black),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                        ]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width,
            height: 20,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                              'Deposit Money'.tr,
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
                          '${changeFormat(currentReservation?.prePaid ?? 0)} đ',
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
                              'Total Paid'.tr,
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
                          '${changeFormat(currentReservation?.paid ?? 0)} đ',
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
      ),
    );
  }
}
