// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/pages/ExplorePage.dart';
import 'package:project_ambw/pages/HomePage.dart';
import 'package:project_ambw/pages/NotificationPage.dart';
import 'package:project_ambw/pages/ProfilePage.dart';
import 'package:project_ambw/pages/TicketPage.dart';

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

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      _appBarTitle = title[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ProfilePage(),)
            );
          },
          child: Icon(
            Icons.account_circle,
          ),
        ),
        title: Text(_appBarTitle),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => NotificationPage(),)
                    );
                  },
                  child: Icon(Icons.notifications),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    AuthService.logout();

                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => LoginPage(),)
                    );
                  },
                  child: Icon(Icons.logout),
                )
              ],
            ),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        iconSize: 30,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Ticket',
          )
        ],
      ),
    );
  }
}
