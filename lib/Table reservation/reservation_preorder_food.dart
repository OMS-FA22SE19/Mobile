// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class testPrior extends StatefulWidget {
  final String jwtToken;
  final int reservationId;
  final List<food>? foodList;
  const testPrior(
      {super.key,
      required this.reservationId,
      required this.foodList,
      required this.jwtToken});

  @override
  State<testPrior> createState() => _testPriorState();
}

class _testPriorState extends State<testPrior> {
  ReservationNoTable? currentReservation;
  int total = 0;
  paymentURL? payment;
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    currentReservation = await RemoteService()
        .getReservationBeforeCheckin(widget.reservationId, widget.jwtToken);
    getVNPAYurl();
    getDirect();
    setState(() {
      total = 0;
    });
    widget.foodList?.forEach((element) {
      total += (element.price * element.quantity);
    });
  }

  getVNPAYurl() async {
    payment = await RemoteService().getPaymentURLReservation(
        widget.reservationId,
        (currentReservation?.prePaid ?? 0) + total,
        widget.jwtToken);
  }

  getDirect() {
    if (currentReservation?.status.contains("Reserved") ?? false) {
      setState(() {
        isDone = true;
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
        title: Text('reservation'.tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        reservationList(jwtToken: widget.jwtToken)),
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
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Remind'.tr,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'You can only checkin before / after 30 minutes of the start time of the reservation'
                            .tr,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('I understand'.tr),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.info_outline_rounded,
                size: 30,
              )),
        ],
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
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
                                'reservation information'.tr,
                                style: GoogleFonts.cabin(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '${'status'.tr}: ${currentReservation?.status.tr}',
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
          SingleChildScrollView(
            child: ExpansionTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Reservation detail'.tr,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                '${'date'.tr}: ${currentReservation?.startTime.toString().substring(0, 10)}',
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
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
                                currentReservation?.tableType ?? "",
                                style: GoogleFonts.cabin(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '${'Number of seats'.tr}: ${currentReservation?.numOfSeats} x ${currentReservation?.quantity}',
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
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
                                '${'time'.tr}: ${currentReservation?.startTime.toString().substring(11, 16)} - ${currentReservation?.endTime.toString().substring(11, 16)}',
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
              ],
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
                'Order Detail'.tr,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                'Food list'.tr,
                style: GoogleFonts.cabin(fontSize: 15, color: Colors.black),
              ),
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.foodList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.greenAccent,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.foodList
                                                ?.elementAt(index)
                                                .name ??
                                            "",
                                        style: GoogleFonts.cabin(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${'Amount'.tr}: ${widget.foodList?.elementAt(index).quantity}',
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${'note'.tr}: ${widget.foodList?.elementAt(index).note}',
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
                                    '${changeFormat(widget.foodList?.elementAt(index).price ?? 0)} đ',
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
                              'Bill money'.tr,
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
                          '${changeFormat(total)} đ',
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
                              'Total Pay'.tr,
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
                          '${changeFormat(((currentReservation?.prePaid ?? 0) + total))} đ',
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
                              'Must pay',
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
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                if (isDone) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => reservationList(
                              jwtToken: widget.jwtToken,
                            )),
                  );
                } else {
                  setState(() {
                    RemoteService().createPreorderFood(
                        widget.reservationId, widget.foodList, widget.jwtToken);
                  });
                  launchUrl(
                    Uri.parse(payment?.url ?? "NULL URL"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: conditionalText(isDone),
                    //     Text(
                    //   isDone.toString(),
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.cabin(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black),
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  conditionalText(bool check) {
    if (check) {
      return Text(
        'Back to menu'.tr,
        textAlign: TextAlign.center,
        style: GoogleFonts.cabin(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      );
    } else {
      return Text(
        'Confirm & Pay'.tr,
        textAlign: TextAlign.center,
        style: GoogleFonts.cabin(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      );
    }
  }
}
