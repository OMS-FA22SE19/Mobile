// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/person_page.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/reservation_detail.dart';
import 'package:oms_mobile/Table%20reservation/reservation_search.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:get/get.dart';

class reservationList extends StatefulWidget {
  final String jwtToken;
  const reservationList({super.key, required this.jwtToken});

  @override
  State<reservationList> createState() => _reservationListState();
}

class _reservationListState extends State<reservationList> {
  List<ReservationNoTable>? reservationsReserved;
  List<ReservationNoTable>? reservationsCheckIn;
  List<ReservationNoTable>? reservationsAvailable;
  final textController = TextEditingController();
  bool isLoaded_1 = false;
  bool isLoaded_2 = false;
  bool isLoaded_3 = false;
  bool flag = false;

  UserProfile? currentUser;
  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getCheckin();
    getReserved();
    getAvailable();
    getUser();
  }

  getCheckin() async {
    reservationsCheckIn = await RemoteService()
        .getReservationsBeforeCheckin("CheckIn", widget.jwtToken);
    if (reservationsCheckIn != null) {
      if (mounted) {
        setState(() {
          isLoaded_1 = true;
        });
      }
    }
  }

  getReserved() async {
    reservationsReserved = await RemoteService()
        .getReservationsBeforeCheckin("Reserved", widget.jwtToken);
    if (reservationsReserved != null) {
      if (mounted) {
        setState(() {
          isLoaded_2 = true;
        });
      }
    }
  }

  getAvailable() async {
    reservationsAvailable = await RemoteService()
        .getReservationsBeforeCheckin("Available", widget.jwtToken);
    if (reservationsAvailable != null) {
      if (mounted) {
        setState(() {
          isLoaded_3 = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:
                  (currentUser?.userName.contains("defaultCustomer") ?? false)
                      ? const Color.fromRGBO(232, 192, 125, 100)
                      : Colors.blue[600],
              centerTitle: true,
              title: Text('Restaurant A',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                  )),
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => searchReservation(
                                jwtToken: widget.jwtToken,
                              )),
                    );
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 30,
                  )),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonPage(
                                  jwtToken: widget.jwtToken,
                                )),
                      );
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                    )),
              ],
              bottom: TabBar(
                indicatorColor:
                    (currentUser?.userName.contains("defaultCustomer") ?? false)
                        ? const Color.fromRGBO(232, 192, 125, 100)
                        : Colors.blue[600],
                indicatorWeight: 2.5,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    text: 'Available'.tr,
                    icon: const Icon(Icons.restaurant_rounded),
                  ),
                  Tab(
                    text: 'Reserved'.tr,
                    icon: const Icon(Icons.restaurant_rounded),
                  ),
                  Tab(
                      text: 'Check In'.tr,
                      icon: const Icon(Icons.restaurant_rounded)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Visibility(
                  visible: isLoaded_3,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getAvailable();
                      });
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: reservationsAvailable?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => reservationDetail(
                                          id: reservationsAvailable![index].id,
                                          jwtToken: widget.jwtToken,
                                        )),
                              );
                            },
                            child: ReservationAvailable(
                                reservationsAvailable![index].status, index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoaded_2,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getReserved();
                      });
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: reservationsReserved?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => reservationDetail(
                                          id: reservationsReserved![index].id,
                                          jwtToken: widget.jwtToken,
                                        )),
                              );
                            },
                            child: ReservationReserved(
                                reservationsReserved![index].status, index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoaded_1,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getCheckin();
                      });
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                      reservationsCheckIn![index].startTime.day.toString() +
                          "/" +
                          reservationsCheckIn![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsCheckIn![index].startTime.year.toString(),
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
                      '${reservationsCheckIn![index].reservationTables.elementAt(0).table.tableType.name} - ${reservationsCheckIn![index].reservationTables.elementAt(0).tableId}',
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

  ReservationReserved(String status, int index) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.yellow[600],
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
                      reservationsReserved![index].startTime.day.toString() +
                          "/" +
                          reservationsReserved![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsReserved![index]
                              .startTime
                              .year
                              .toString(),
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
                      reservationsReserved![index]
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
                      reservationsReserved![index]
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
                      reservationsReserved![index].status.tr,
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

  ReservationAvailable(String status, int index) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
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
                      reservationsAvailable![index].startTime.day.toString() +
                          "/" +
                          reservationsAvailable![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsAvailable![index]
                              .startTime
                              .year
                              .toString(),
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
                      reservationsAvailable![index]
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
                      reservationsAvailable![index]
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
                      reservationsAvailable![index].status.tr,
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
