import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  ReservationNoTable? currentReservation;
  int total = 0;
  paymentURL? payment;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    getURL();
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  getURL() async {
    // payment = await RemoteService().getPaymentURLReservation(61, 100000);
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
        // initialUrl: payment?.url,
        initialUrl:
            "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=10000000&vnp_Command=pay&vnp_CreateDate=20221109034410&vnp_CurrCode=VND&vnp_ExpireDate=20221109035910&vnp_IpAddr=http%3A%2F%2Flocalhost%3A5246&vnp_Locale=vn&vnp_OrderInfo=Thanh+toan+cho+reservation%3A+61&vnp_ReturnUrl=http%3A%2F%2F10.0.2.2%3A5246%2Fapi%2Fv1%2FVNPay%2FReservation%2FResponse&vnp_TmnCode=E1A98N09&vnp_TxnRef=20221109034410&vnp_Version=2.1.0&vnp_SecureHash=52edf81c27af857b089c280c4569155e7079bb91b6177a48dba8c587087487d96507ced53aab64738583a980fe5c8d16cd43b82d42e241143182236c65434fa1");
  }
}
