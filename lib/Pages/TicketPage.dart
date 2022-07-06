// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unused_field

import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/DetailTicketPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/storageService.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  int _currentindexTab = 0;

  final List<Tab> _ticketTab = [
    Tab(text: 'Waitting'),
    Tab(text: 'Active'),
    Tab(text: 'Rejected'),
    Tab(text: 'Used'),
  ];

  Widget ticketCard(Order order) {
    SportCentre sc = order.sportCentre;
    SportField sf = order.sportField;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailTicketPage(dataOrder: order);
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        //padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //image
                sf.fieldPicture == ""
                    ? Icon(Icons.image, size: 100, color: Colors.white)
                    : FutureBuilder<String>(
                        future: StorageService.getDownloadUrl(
                          imageName: sf.fieldPicture,
                          isProfilePicture: false,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else if (snapshot.hasData ||
                              snapshot.data != null) {
                            print(snapshot.data!);
                            return imageNetwork(snapshot.data!, 100, 110);
                          }
                          return progressIndicator();
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Text(
                        "${sc.name} (${sf.name})",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //ket
                      textWithIconRow(Icons.calendar_today, order.date),
                      textWithIconRow(Icons.alarm, order.time),
                      SizedBox(
                        height: 5,
                      ),
                      //field type
                      sportCard(order.sportField.fieldType,
                          sportColor(order.sportField.fieldType)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: iconStatus(order.status),
            ),
          ],
        ),
      ),
    );

    // return ListTile(
    //   onTap: () {
    //     dialogTicket(context, order);
    //   },
    //   shape: roundedRectangleBorder(),
    //   contentPadding: EdgeInsets.all(8),
    //   tileColor: Colors.black,
    //   leading: imageNetwork(imagePath, 100, 100),
    //   title: Text(
    //     "${sc.name} (${sf.name})",
    //     style: TextStyle(
    //       fontSize: 14,
    //       color: Colors.white,
    //     ),
    //   ),
    //   subtitle: Row(
    //     children: [
    //       sportCard(sf.fieldType, sportColor(sf.fieldType)),
    //     ],
    //   ),
    //   trailing: iconStatus(order.status),
    // );
  }

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
          title: Center(child: title("${sc.name} (${sf.name})", true)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ticketQRCode(order.id, 200),
              SizedBox(
                height: 20,
              ),
              textWithIconRow(Icons.location_on, sc.address),
              textWithIconRow(Icons.phone, sc.phoneNumber),
              textWithIconRow(Icons.price_change, "Rp. ${order.amount}"),
              textWithIconRow(Icons.calendar_today, order.date),
              textWithIconRow(Icons.alarm, order.time),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _ticketTab.length,
      child: Builder(
        builder: (context) {
          TabController _tabController = DefaultTabController.of(context)!;

          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _currentindexTab = _tabController.index;
              });
            }
          });
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title('Manage your', false),
                  title('Reservation', true),
                  SizedBox(
                    height: 30,
                  ),
                  TabBar(
                    tabs: _ticketTab,
                    labelColor: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConsumerSession.session.orderId.isEmpty
                      ? emptyText()
                      : StreamBuilder<QuerySnapshot>(
                          stream: OrderFirestoreDatabase.getDataByConsumer(
                              ConsumerSession.session),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else if (snapshot.hasData ||
                                snapshot.data != null) {
                              List<Order> listOrder = [];

                              for (var i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                DocumentSnapshot dsData =
                                    snapshot.data!.docs[i];
                                Order order = Order.fromDocument(dsData);

                                //cek status consumer order
                                if (order.status == _currentindexTab) {
                                  listOrder.add(order);
                                }
                              }

                              if (listOrder.isEmpty) {
                                return emptyText();
                              }

                              return Expanded(
                                  child: ListView.separated(
                                  itemCount: listOrder.length,
                                  itemBuilder: (context, index) {
                                    return ticketCard(listOrder[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                ),
                              );
                            }
                            return progressIndicator();
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
