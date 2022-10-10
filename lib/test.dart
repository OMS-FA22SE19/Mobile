import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatefulWidget {
  final String? orderId;
  final int? total;
  const Test({super.key, required this.orderId, required this.total});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  paymentURL? payment;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    payment = await RemoteService().getPaymentURL(widget.orderId, widget.total);
    if (paymentURL != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test',
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'This is no Link, ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'but this is',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                            mode: LaunchMode.externalApplication,
                            Uri.parse(payment?.url ?? ""));
                        // launchUrl(Uri.parse("https://www.youtube.com"));
                      },
                  ),
                ],
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
