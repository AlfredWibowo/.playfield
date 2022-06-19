// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/main.dart';
import 'package:project_ambw/pages/admin/AddFieldPage.dart';
import 'package:project_ambw/pages/admin/HomePage.dart';
import 'package:project_ambw/pages/admin/MaintenancePage.dart';
import 'package:project_ambw/pages/admin/NotificationPage.dart';
import 'package:project_ambw/pages/admin/ProfilePage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBottomNavigationPage extends StatefulWidget {
  const AdminBottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<AdminBottomNavigationPage> createState() =>
      _AdminBottomNavigationPageState();
}

class _AdminBottomNavigationPageState extends State<AdminBottomNavigationPage> {
  int _currentIndex = 0;

  List<String> title = ['Home', 'Add Field', 'Maintenance'];
  String _appBarTitle = "Home";

  final List<Widget> _screens = [
    AdminHomePage(),
    AdminAddFieldPage(),
    AdminMaintenancePage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      _appBarTitle = title[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: AdminFirestoreDatabase.getDataByEmail(
        AuthService.getEmailUser(),
        //"admin@gmail.com"
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
                child: appBarIconBtn(
                    context, Icons.account_circle_outlined, AdminProfilePage()),
              ),
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      appBarIconBtn(context, Icons.notifications_outlined,
                          AdminNotificationPage()),
                      SizedBox(
                        width: 20,
                      ),
                      appBarIconBtn(context, Icons.logout, WelcomePage()),
                    ],
                  ),
                )
              ],
            ),
            body: _screens[_currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: BottomNavigationBar(
                onTap: onTappedBar,
                currentIndex: _currentIndex,
                iconSize: 30,
                elevation: 0,
                backgroundColor: Colors.transparent,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                items: [
                  bottomNavigationBarItem(Icon(Icons.home), 'Home'),
                  bottomNavigationBarItem(
                      Icon(Icons.add_circle), 'Add Field'),
                  bottomNavigationBarItem(
                      Icon(Icons.settings), 'Maintenance'),
                ],
              ),
            ),
          );
        }

        return progressIndicator();
      },
    );
  }
}
