// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            title('Hello,', false),
            title(UserSession.session.nama, true),
            SizedBox(
              height: 30,
            ),
            subTitle('Reservation', false, () {}),
            SizedBox(
              height: 10,
            ),
            reservationCard('GORD Sudirman', '16/6/2022'),
            SizedBox(
              height: 30,
            ),
            subTitle('Lastest Visit', true, () {}),
            SizedBox(height: 10),
            lastVisitCard(),
            lastVisitCard(),
          ],
        ),
      ),
    );
  }
}
