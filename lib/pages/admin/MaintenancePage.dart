// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:flutter/material.dart';

class AdminMaintenancePage extends StatefulWidget {
  const AdminMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AdminMaintenancePage> createState() => _AdminMaintenancePageState();
}

class _AdminMaintenancePageState extends State<AdminMaintenancePage> {
  Widget appliantCard(Order order) {
    SportCentre sc = order.sportCentre;
    SportField sf = order.sportField;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: imageNetwork(imagePath, 100, 100),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${sc.name} (${sf.name})',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              textWithIconRow(Icons.calendar_today, order.date),
              textWithIconRow(Icons.alarm, order.time),
              textWithIconRow(Icons.price_change, "Rp. ${order.amount}"),
              SizedBox(
                height: 10,
              ),
              sportCard(sf.fieldType, sportColor(sf.fieldType)),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.check),
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    primary: Color.fromARGB(255, 116, 227, 19),
                    shape: roundedRectangleBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.close),
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    primary: Color.fromARGB(255, 251, 11, 11),
                    shape: roundedRectangleBorder()),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            title('Manage your', false),
            title('Order', true),
            SizedBox(
              height: 30,
            ),
            
          ],
        ),
      ),
    );
  }
}
