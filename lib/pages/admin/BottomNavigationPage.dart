// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/main.dart';
import 'package:project_ambw/pages/admin/SportCentreListPage.dart';
import 'package:project_ambw/pages/admin/HomePage.dart';
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

  final List<String> title = ['Home', 'Manage Field', 'Maintenance'];

  final List<Widget> _screens = [
    AdminHomePage(),
    SportCentreListPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: AdminFirestoreDatabase.getDataByEmail(
        AuthService.getEmailUser(),
        //"admin1@gmail.com"
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData || snapshot.data != null) {
          Admin newSession = Admin.fromDocument(snapshot.data!);
          AdminSession.updateSession(newSession: newSession);

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(16.0),
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
                color: Color.fromARGB(255, 152, 173, 166),
                boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, -2), // changes position of shadow
                    )
                ],
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
                      Icon(Icons.settings), 'Manage'),
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
