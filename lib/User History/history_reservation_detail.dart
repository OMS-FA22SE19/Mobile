// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/services/remote_service.dart';

class historyReservationDetail extends StatefulWidget {
  final int reservationId;
  const historyReservationDetail({super.key, required this.reservationId});

  @override
  State<historyReservationDetail> createState() =>
      _historyReservationDetailState();
}

class _historyReservationDetailState extends State<historyReservationDetail> {
  ReservationNoTable? currentReservation;
  var isloaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    currentReservation =
        await RemoteService().getReservationBeforeCheckin(widget.reservationId);
    if (currentReservation != null) {
      setState(() {
        isloaded = true;
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
        title: Text(currentReservation?.startTime.toString() ?? "",
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
                              currentReservation?.status ?? "",
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
        ExpansionTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            'Reservation Detail',
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          subtitle: Text(
            'Table list',
            style: GoogleFonts.cabin(fontSize: 15, color: Colors.black),
          ),
          children: [
            SafeArea(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currentReservation?.reservationTables.length,
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
                                  'ID: ${currentReservation?.reservationTables.elementAt(index).table.id}',
                                  style: GoogleFonts.cabin(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Type: ${currentReservation?.reservationTables.elementAt(index).table.tableType.name}',
                                  style: GoogleFonts.cabin(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Number of Seats: ${currentReservation?.reservationTables.elementAt(index).table.numOfSeats}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Charge per seats: ${changeFormat(currentReservation?.reservationTables.elementAt(index).table.tableType.chargePerSeat ?? 0)} đ',
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
                              changeFormat((currentReservation
                                          ?.reservationTables
                                          .elementAt(index)
                                          .table
                                          .tableType
                                          .chargePerSeat ??
                                      0) *
                                  (currentReservation?.numOfSeats ?? 0)),
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
            )
          ],
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
                    '- ${changeFormat(currentReservation?.id ?? 0)} đ',
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
                    '${changeFormat(currentReservation?.id ?? 0)} đ',
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
