// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/reservation_detail.dart';
import 'package:oms_mobile/services/remote_service.dart';

class searchReservationResult extends StatefulWidget {
  final String searchValue;
  final String jwtToken;
  // final List<ReservationNoTable>? reservationsCheckIn;
  const searchReservationResult(
      {super.key, required this.jwtToken, required this.searchValue});

  @override
  State<searchReservationResult> createState() =>
      _searchReservationResultState();
}

class _searchReservationResultState extends State<searchReservationResult> {
  bool isLoaded = false;
  List<ReservationNoTable>? reservationsCheckIn;

  UserProfile? currentUser;
  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getData();
    getUser();
  }

  getData() async {
    reservationsCheckIn = await RemoteService()
        .getReservationsSearch(widget.searchValue, widget.jwtToken);
    if (reservationsCheckIn != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => homeScreen(
                          jwtToken: widget.jwtToken,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        backgroundColor:
            (currentUser?.userName.contains("defaultCustomer") ?? false)
                ? const Color.fromRGBO(232, 192, 125, 100)
                : Colors.blue[600],
        centerTitle: true,
        title: Text(
          'Result'.tr.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Visibility(
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          visible: isLoaded,
          child: ListView.builder(
            itemCount: reservationsCheckIn?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => reservationDetail(
                                id: reservationsCheckIn![index].id,
                                jwtToken: widget.jwtToken,
                              )),
                    );
                  },
                  child: ReservationCheckIn(
                      reservationsCheckIn![index].status, index),
                ),
              );
            },
          )),
    );
  }

  ReservationCheckIn(String status, int index) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: (status.contains("Reserved"))
            ? Colors.yellow[600]
            : status.contains("Available")
                ? Colors.blueAccent
                : Colors.greenAccent,
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
                'reservation information'.tr.toUpperCase(),
                maxLines: 2,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(children: [
                    Text(
                      '${'date'.tr}:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "${reservationsCheckIn![index].startTime.day}/${reservationsCheckIn![index].startTime.month}/${reservationsCheckIn![index].startTime.year}",
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${'Start Time'.tr}:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index]
                          .startTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${'End Time'.tr}:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index]
                          .endTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${'status'.tr}:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index].status.tr,
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${'table'.tr}:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index]
                          .reservationTables
                          .elementAt(0)
                          .tableId
                          .toString(),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                ],
              ),
            ]),
      ),
    );
  }
}
