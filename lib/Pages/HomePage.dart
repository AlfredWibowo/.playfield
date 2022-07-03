// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget balanceCard(Consumer session) {
    return Container(
      width: 85.60 * 3.5,
      height: 53.98 * 3.5,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rp. ${session.balance}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              FlutterLogo(),
            ],
          ),
          //bot
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.email,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    session.name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  dialogTopUp();
                },
                icon: Icon(
                  Icons.add_card,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget bookingCard(Order order) {
    SportCentre sc = order.sportCentre;
    SportField sf = order.sportField;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: imageNetwork(imagePath, 0, 128),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sc.name} (${sf.name})',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                textWithIconRow(Icons.phone, sc.phoneNumber),
                textWithIconRow(Icons.location_on, sc.address),
                SizedBox(
                  height: 30,
                ),
                textWithIconRow(Icons.calendar_today, order.date),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dialogTopUp() {
    TextEditingController _tfController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // dialogContext = context;
        return AlertDialog(
          insetPadding: EdgeInsets.all(24.0),
          title: Text(
            ('top up balance').toUpperCase(),
            style: const TextStyle(fontFamily: 'Comfortaa'),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    ListTile(
                      subtitle: TextField(
                        controller: _tfController,
                        decoration: InputDecoration(
                          labelText: "Rp.",
                          focusedBorder: outlineInputBorder(),
                          enabledBorder: outlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), // <-- Radius
                        ),
                        elevation: 0.0,
                        primary: Colors.black,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        ConsumerSession.session.balance +=
                            double.parse(_tfController.text);

                        ConsumerFirestoreDatabase.editData(
                            consumer: ConsumerSession.session);

                        buildSnackBar(context, "Top Up Succesfull");

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                            fontFamily: 'Roboto', color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        );
      },
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title('Hello,', false),
              title(ConsumerSession.session.name, true),
              SizedBox(
                height: 30,
              ),
              subTitle("Balance"),
              SizedBox(
                height: 10,
              ),
              balanceCard(ConsumerSession.session),
              SizedBox(
                height: 20,
              ),

              //cek consumer have order or not
              ConsumerSession.session.orderId.isEmpty
                  ? Container()
                  : StreamBuilder<QuerySnapshot>(
                      stream: OrderFirestoreDatabase.getDataByConsumer(
                          ConsumerSession.session),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData || snapshot.data != null) {
                          //add to list order
                          List<Order> listOrderActive = [];
                          List<Order> listOrderUsed = [];

                          for (var i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot dsData = snapshot.data!.docs[i];
                            Order order = Order.fromDocument(dsData);

                            if (ConsumerSession.session.orderId
                                .contains(order.id)) {
                              if (order.status == 1) {
                                listOrderActive.add(order);
                              }
                              if (order.status == 3) {
                                listOrderUsed.add(order);
                              }
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //reservation
                              listOrderActive.isEmpty
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            subTitle('Reservation'),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                'See All',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        bookingCard(listOrderActive.last),
                                      ],
                                    ),
                              SizedBox(
                                height: 20,
                              ),

                              //latest visit
                              listOrderUsed.isEmpty
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            subTitle('Lastest Visit'),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                'See All',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        bookingCard(listOrderUsed.last),
                                      ],
                                    ),
                            ],
                          );
                        }
                        return progressIndicator();
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
