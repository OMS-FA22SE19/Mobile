// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/table.dart';
import 'package:oms_mobile/Table%20reservation/date_picker.dart';
import 'package:oms_mobile/Table%20reservation/table_reservation.dart';
import 'package:oms_mobile/services/remote_service.dart';

class tablePicker extends StatefulWidget {
  const tablePicker({super.key, required this.numberOfPeople});

  final int numberOfPeople;

  @override
  State<tablePicker> createState() => _tablePickerState();
}

class _tablePickerState extends State<tablePicker> {
  List<table>? tables;
  bool isLoaded = false;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }

  getData() async {
    tables = await RemoteService().getTablesAvailable(widget.numberOfPeople);
    if (tables != null) {
      setState(() {
        isLoaded = true;
        flag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(232, 192, 125, 100),
          centerTitle: true,
          title: Text('Reservation',
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => tableReservation()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 30,
              )),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                )),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: conditonalWidget());
  }

  conditonalWidget() {
    if (flag) {
      return Visibility(
        visible: isLoaded,
        // ignore: sort_child_properties_last
        child: ListView.builder(
          itemCount: tables?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => datePicker(
                            numberOfPeople: widget.numberOfPeople,
                            numberOfSeats: tables![index].numOfSeats,
                            tableTypeId: tables![index].tableTypeId,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(232, 192, 125, 50),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.table_bar_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tables![index].tableTypeName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Number of seats: " +
                                    tables![index].numOfSeats.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                "Table available: " +
                                    tables![index].total.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ]),
                ),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No Table Available",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cabin(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "We sorry that we can't adapt your expectation right now. Hope we can see you in another day.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cabin(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }
}
