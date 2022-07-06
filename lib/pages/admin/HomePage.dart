// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:intl/intl.dart';
import 'package:project_ambw/class/Notification.dart';
import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/pages/admin/QRCodeScannerPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/storageService.dart';
import 'package:uuid/uuid.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Widget qrCodeScannerCard() {
    return Card(
      color: Colors.black,
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeScannerPage(),
              ));
        },
        title: Text(
          'scan here'.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        trailing: Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget latestAppliantCard(Order order) {
    SportCentre sc = order.sportCentre;
    SportField sf = order.sportField;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: sf.fieldPicture == ""
                ? Icon(Icons.image, size: 100, color: Colors.white)
                : FutureBuilder<String>(
                    future: StorageService.getDownloadUrl(
                      imageName: sf.fieldPicture,
                      isProfilePicture: false,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        print(snapshot.data!);
                        return imageNetwork(snapshot.data!, 100, 100);
                      }
                      return progressIndicator();
                    },
                  ),
          ),
          // SizedBox(
          //   width: 20,
          // ),
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
          // SizedBox(
          //   width: 20,
          // ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  //acc jd active
                  order.status = 1;
                  OrderFirestoreDatabase.editData(order: order);

                  //add notif to consumer
                  String notifId = Uuid().v4();
                  String notifMsg =
                      "Your order with order id ${order.id} Accepted by Admin";
                  var formatter = DateFormat("dd/MM/yyyy");
                  String formattedDate = formatter.format(DateTime.now());
                  Notif notif = Notif(
                      id: notifId, date: formattedDate, message: notifMsg, isRead: false);

                  Consumer consumer = order.consumer;
                  consumer.notifId.add(notifId);
                  ConsumerFirestoreDatabase.editData(consumer: consumer);

                  //add notif to db
                  NotifFirestoreDatabase.addData(notif: notif);

                  buildSnackBar(context, "Order Accepted");
                },
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
                onPressed: () {
                  //rejected
                  order.status = 2;
                  OrderFirestoreDatabase.editData(order: order);
                  buildSnackBar(context, "Order Rejected");
                },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Hello,', false),
            title(AdminSession.session.name, true),
            SizedBox(
              height: 30,
            ),
            subTitle('Scan QR Code'),
            SizedBox(
              height: 10,
            ),
            qrCodeScannerCard(),
            SizedBox(
              height: 30,
            ),
            AdminSession.session.orderId.isEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subTitle('Latest Appliant'),
                      SizedBox(
                        height: 10,
                      ),
                      AdminSession.session.orderId.isEmpty
                          ? Container()
                          : StreamBuilder<QuerySnapshot>(
                              stream: OrderFirestoreDatabase.getDataByAdmin(
                                  AdminSession.session),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                } else if (snapshot.hasData ||
                                    snapshot.data != null) {
                                  //add to list order by arr order id

                                  List<Order> listOrder = [];

                                  for (var i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    DocumentSnapshot dsData =
                                        snapshot.data!.docs[i];

                                    Order order = Order.fromDocument(dsData);

                                    if (order.status == 0) {
                                      listOrder.add(order);
                                    }
                                  }

                                  // if (listOrder.isEmpty) {
                                  //   return emptyText();
                                  // }

                                  return Container(
                                    height: 148,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return latestAppliantCard(
                                            listOrder[index]);
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 10,
                                      ),
                                      itemCount: listOrder.length,
                                    ),
                                  );
                                }
                                return progressIndicator();
                              },
                            ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
