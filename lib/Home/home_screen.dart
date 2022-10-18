// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Login/login_page.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Table%20reservation/reservation_detail.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import '../Table reservation/table_reservation.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<ReservationNoTable>? reservations;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    reservations = await RemoteService().getReservationsBeforeCheckin();
    if (reservations != null) {
      setState(() {
        isLoaded = true;
      });
      // int? checkId = 0;
      // List<int> checkList = [];
      // reservations?.forEach((element) {
      //   String check = element.status;
      //   if (check.contains("Available")) {
      //     checkId = reservations?.indexOf(element);
      //     checkList.add(checkId!);
      //   }
      // });
      // checkList.forEach((element) {
      //   reservations?.removeAt(element);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(232, 192, 125, 100),
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          'Hello! We hope you have a good day!',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                              'Tran Minh Quan',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    'Table Reservation',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => tableReservation()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Menu',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => menuCategory(
                                tableId: 0,
                              )),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'History',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => historyPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(232, 192, 125, 100),
            centerTitle: true,
            title: Text('Restaurant A',
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                  )),
            ],
            bottom: const TabBar(
              indicatorColor: Color.fromRGBO(232, 192, 125, 100),
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Reservations",
                  icon: Icon(Icons.table_bar_rounded),
                ),
                Tab(text: "Recommend", icon: Icon(Icons.restaurant_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: TabBarView(
            children: [
              //
              //
              //
              //
              //TAB 1
              Visibility(
                  visible: isLoaded,
                  child: ListView.builder(
                    itemCount: reservations?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => reservationDetail(
                                        id: reservations![index].id,
                                      )),
                            );
                          },
                          child: conditionalReservation(
                              reservations![index].status, index),
                        ),
                      );
                    },
                  )),

              //
              //
              //
              //
              //TAB 2
              SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                    },
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(232, 192, 125, 100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Icon(
                            Icons.fastfood_outlined,
                            size: 120,
                            color: Colors.white,
                          ),
                          Text(
                            'Main Course',
                            style: GoogleFonts.cabin(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Rate: 4.5 / 5',
                            style: GoogleFonts.cabin(
                                fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            "Price: \$\$\$\$",
                            style: GoogleFonts.cabin(
                                fontSize: 18, color: Colors.white),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  conditionalReservation(String status, int index) {
    if (status.contains("CheckIn")) {
      return Container(
        height: 230,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
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
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservations![index].startTime.day.toString() +
                            "/" +
                            reservations![index].startTime.month.toString() +
                            "/" +
                            reservations![index].startTime.year.toString(),
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
                        reservations![index]
                            .startTime
                            .toString()
                            .substring(11, 16),
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
                        reservations![index]
                            .endTime
                            .toString()
                            .substring(11, 16),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Status:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservations![index].status,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ]),
        ),
      );
    } else if (status.contains("Reserved")) {
      return Container(
        height: 230,
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
                  'RESERVATION INFORMATION',
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
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservations![index].startTime.day.toString() +
                            "/" +
                            reservations![index].startTime.month.toString() +
                            "/" +
                            reservations![index].startTime.year.toString(),
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
                        reservations![index]
                            .startTime
                            .toString()
                            .substring(11, 16),
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
                        reservations![index]
                            .endTime
                            .toString()
                            .substring(11, 16),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Status:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservations![index].status,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ]),
        ),
      );
    } else {
      return Container(
        height: 220,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.red,
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
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservations![index].startTime.day.toString() +
                            "/" +
                            reservations![index].startTime.month.toString() +
                            "/" +
                            reservations![index].startTime.year.toString(),
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
                        reservations![index]
                            .startTime
                            .toString()
                            .substring(11, 16),
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
                        reservations![index]
                            .endTime
                            .toString()
                            .substring(11, 16),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ]),
        ),
      );
    }
  }
}
