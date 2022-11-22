import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bye'.tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'hello'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  var locale = Locale('en', 'US');
                  Get.updateLocale(locale);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                  child: Text("English",
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  var locale = Locale('vi', 'VN');
                  Get.updateLocale(locale);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: Text("Tiếng Việt",
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
          // BlocBuilder<LanguageCubit, Locale?>(
          //   builder: ((context, state) {
          //     return
          //   }),
          // ),
        ],
      ),
    );
  }
}
