import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/services/remote_service.dart';

class orderMethod extends StatefulWidget {
  final String? orderid;
  final String method;

  const orderMethod({super.key, required this.orderid, required this.method});

  @override
  State<orderMethod> createState() => _orderMethodState();
}

class _orderMethodState extends State<orderMethod> {
  order? currentOrder;
  var isLoaded;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    currentOrder = await RemoteService().getOrders(widget.orderid);
    if (currentOrder != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("Order",
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => menuCategory()),
                );
              },
              icon: Icon(
                Icons.menu_book_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.local_dining_rounded,
            size: 150,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Payment method: " + widget.method,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cabin(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Total: ",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cabin(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                currentOrder?.total.toString() ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cabin(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                " Đồng",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cabin(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.green,
            child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(159, 192, 136, 80),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_dining_rounded,
                        size: 100,
                        color: Colors.grey,
                      ),
                      Text(
                        'Online Method',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
