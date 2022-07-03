// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:aplikasi_booking_lapangan_online/class/User.dart';
import 'package:aplikasi_booking_lapangan_online/class/UserSesssion.dart';
import 'package:aplikasi_booking_lapangan_online/functions/widget.dart';
import 'package:aplikasi_booking_lapangan_online/main.dart';
import 'package:aplikasi_booking_lapangan_online/pages/FavoritePage.dart';
import 'package:aplikasi_booking_lapangan_online/pages/NotificationPage.dart';
import 'package:aplikasi_booking_lapangan_online/pages/ProfilePage.dart';
import 'package:aplikasi_booking_lapangan_online/services/authService.dart';
import 'package:aplikasi_booking_lapangan_online/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_booking_lapangan_online/pages/ExploreSCPage.dart';
import 'package:aplikasi_booking_lapangan_online/pages/HomePage.dart';
import 'package:aplikasi_booking_lapangan_online/pages/TicketPage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  final List<String> title = ['Home', 'Explore', 'Ticket'];

  final List<Widget> _screens = [
    HomePage(),
    ExploreSCPage(),
    TicketPage(),
  ];

  late String emailUser;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  IconButton appBarIconBtn(BuildContext context, IconData icon, Widget page) {
    if (icon == Icons.logout) {
      return IconButton(
        onPressed: () {
          AuthService.logout();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        icon: appBarIcon(icon),
      );
    }
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        ).then((value) => setState(() {}));
      },
      icon: appBarIcon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: ConsumerFirestoreDatabase.getDataByEmail(
          AuthService.getEmailUser(),
          //"consumer1@gmail.com"
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData || snapshot.data != null) {
            Consumer newSession = Consumer.fromDocument(snapshot.data!);
            ConsumerSession.updateSession(newSession: newSession);

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: appBarIconBtn(
                      context, Icons.account_circle_outlined, ProfilePage()),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        appBarIconBtn(
                            context, Icons.favorite_outline, FavoritePage()),
                        SizedBox(
                          width: 20,
                        ),
                        appBarIconBtn(context, Icons.notifications_outlined,
                            NotificationPage()),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            AuthService.logout();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomePage(),
                              ),
                            );
                          },
                          icon: appBarIcon(Icons.logout),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: _screens[_currentIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(80, 165, 175, 100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, -2), // changes position of shadow
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
                child: BottomNavigationBar(
                  onTap: onTappedBar,
                  currentIndex: _currentIndex,
                  iconSize: 30,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.white,
                  items: [
                    bottomNavigationBarItem(Icon(Icons.home), 'Home'),
                    bottomNavigationBarItem(
                        Icon(Icons.explore_outlined), 'Explore'),
                    bottomNavigationBarItem(
                        Icon(Icons.sports_handball), 'Ticket'),
                  ],
                ),
              ),
            );
          }

          return progressIndicator();
        });
  }
}
