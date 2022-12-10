import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Table%20reservation/reservation_detail.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final String jwtToken;
  final int id;
  const QRPage({super.key, required this.jwtToken, required this.id});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('QR CODE'.tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => reservationDetail(
                          id: widget.id,
                          jwtToken: widget.jwtToken,
                        )),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => PersonPage(
          //                   jwtToken: widget.jwtToken,
          //                 )),
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.person,
          //       size: 30,
          //     )),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: QrImage(
          data:
              'https://localhost:7246/api/v1/Reservations/${widget.id}/Checkin',
          size: 300,
        ),
      ),
    );
  }
}
