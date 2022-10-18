// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/services/remote_service.dart';

class reservationDetail extends StatefulWidget {
  final int id;
  const reservationDetail({super.key, required this.id});

  @override
  State<reservationDetail> createState() => _reservationDetailState();
}

class _reservationDetailState extends State<reservationDetail> {
  ReservationNoTable? reservation;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    reservation = await RemoteService().getReservationBeforeCheckin(widget.id);
    if (reservation != null) {
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
        title: Text('Detail',
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
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homeScreen()),
                );
              },
              icon: const Icon(
                Icons.info_outline_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Visibility(
        visible: isLoaded,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                // height: 400,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.table_restaurant_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                        Text(
                          'RESERVATION INFORMATION',
                          maxLines: 2,
                          style: GoogleFonts.cabin(
                              fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(180),
                            1: FlexColumnWidth(),
                          },
                          children: <TableRow>[
                            TableRow(children: [
                              Text(
                                'Date:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.startTime
                                        .toString()
                                        .substring(0, 10)
                                        .replaceAll('-', '/') ??
                                    "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Start Time:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.startTime
                                        .toString()
                                        .substring(11, 16) ??
                                    "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'End Time:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.endTime
                                        .toString()
                                        .substring(11, 16) ??
                                    "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Number of People:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.numOfPeople.toString() ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Number of Seats:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.numOfSeats.toString() ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Table amount:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.quantity.toString() ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Table type:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.tableType ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            const TableRow(children: [
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Full Name',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.user.fullName ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Phone Number',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.user.phoneNumber ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            const TableRow(children: [
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'Status',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                reservation?.status ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                RemoteService()
                                    .cancelReservation(reservation?.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const homeScreen()),
                                );
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Check In',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
