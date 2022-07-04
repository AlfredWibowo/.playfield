// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailTicketPage extends StatefulWidget {
  final Order dataOrder;

  const DetailTicketPage({Key? key, required this.dataOrder}) : super(key: key);

  @override
  State<DetailTicketPage> createState() => _DetailTicketPageState();
}

class _DetailTicketPageState extends State<DetailTicketPage> {
  Widget ticketQRCode(String uuid, double size) {
    return Center(
      child: Container(
        width: size,
        height: size,
        child: QrImage(
          data: uuid,
          version: QrVersions.auto,
          size: size,
          gapless: false,
        ),
      ),
    );
  }

  void dialogTicket(BuildContext context, Order order) {
    SportCentre sc = order.sportCentre;
    SportField sf = order.sportField;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: Center(child: title("${sc.name} (${sf.name})", true)),
          //title: Center(child: title('QR Code', true)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ticketQRCode(order.id, 200),
              // SizedBox(
              //   height: 20,
              // ),
              // textWithIconRow(Icons.location_on, sc.address),
              // textWithIconRow(Icons.phone, sc.phoneNumber),
              // textWithIconRow(Icons.price_change, "Rp. ${order.amount}"),
              // textWithIconRow(Icons.calendar_today, order.date),
              // textWithIconRow(Icons.alarm, order.time),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.dataOrder;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: backButton(context),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Ticket Detail', false),
            SizedBox(
              height: 30,
            ),
            //title
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Image.network(
                    imagePath,
                    width: 100,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.sportCentre.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'GOR ${order.sportField.fieldType} (${order.sportField.name})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.sportCentre.address,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.date,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.time,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //statsus
            Container(
              color: Colors.amber[700],
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Id Order',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order.id,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        dialogTicket(context, widget.dataOrder);
                      },
                      icon: Icon(Icons.qr_code)),
                ],
              ),
            ),
            //detail
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp. ${order.amount}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
