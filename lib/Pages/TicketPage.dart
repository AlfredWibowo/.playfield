// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

String imagePath = "";

class _TicketPageState extends State<TicketPage> {
  int _currentindexTab = 0;

  final List<Tab> _ticketTab = [
    Tab(text: 'Active'),
    Tab(text: 'Used'),
    Tab(text: 'Canceled'),
  ];

  late List<FieldOccupancy> _listTicket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: AdminFirestoreDatabase.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData || snapshot.data != null) {
          List<Admin> listAdmin = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            DocumentSnapshot dsData = snapshot.data!.docs[i];
            Admin tmp = Admin.fromDocument(dsData);
            listAdmin.add(tmp);
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: ConsumerFirestoreDatabase.tbConsumer
                .doc(AuthService.getEmailUser())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData || snapshot.data != null) {
                DocumentSnapshot ds = snapshot.data!;

                Consumer consumer = Consumer.fromDocument(ds);

                List<String> listUuid = consumer.tickets;

                List<FieldOccupancy> listTicket = [];
                List<Field> listField = [];

                // for (var admin in listAdmin) {
                //   for (var gedung in admin.owns) {
                //     for (var field in gedung.fields) {
                //       for (var occupancy in field.occupancies) {
                //         if (consumer.tickets.contains(occupancy.ticketID)) {
                //           listTicket.add(occupancy);
                //           //listField.add(field);
                //         }
                //       }
                //     }
                //   }
                // }

                return DefaultTabController(
                  length: _ticketTab.length,
                  child: Builder(
                    builder: (context) {
                      TabController _tabController =
                          DefaultTabController.of(context)!;

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
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        title('Manage your', false),
                                        title('Reservation', true),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TabBar(
                                  tabs: _ticketTab,
                                  labelColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: listTicket
                                      .where((element) =>
                                          element.status == _currentindexTab)
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    List<FieldOccupancy> filtered = listTicket
                                        .where(
                                          (element) =>
                                              element.status ==
                                              _currentindexTab,
                                        )
                                        .toList();

                                    return ticketCard(
                                      context,
                                      filtered[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return progressIndicator();
            },
          );
        }
        return progressIndicator();
      },
    );
  }
}
