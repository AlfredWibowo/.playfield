// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/main.dart';
import 'package:project_ambw/pages/FavoritePage.dart';
import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/pages/NotificationPage.dart';
import 'package:project_ambw/pages/ProfilePage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/pages/ExplorePage.dart';
import 'package:project_ambw/pages/HomePage.dart';
import 'package:project_ambw/pages/TicketPage.dart';
//import 'package:project_ambw/pages/NotificationPage.dart'

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  List<String> title = ['Home', 'Explore', 'Ticket'];
  String _appBarTitle = "Home";

  final List<Widget> _screens = [
    HomePage(),
    ExplorePage(),
    TicketPage(),
  ];

  late String emailUser;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      _appBarTitle = title[index];
    });
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
            UserCls newSession = UserCls.fromDocument(snapshot.data!);
            UserSession.updateSession(newSession: newSession);
            
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: appBarIconBtn(context, Icons.account_circle_outlined, ProfilePage()),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        appBarIconBtn(context, Icons.favorite_outline, FavoritePage()),
                        SizedBox(
                          width: 20,
                        ),
                        appBarIconBtn(context, Icons.notifications_outlined, NotificationPage()),
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
                  color: Color.fromARGB(255, 80, 165, 175),
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
