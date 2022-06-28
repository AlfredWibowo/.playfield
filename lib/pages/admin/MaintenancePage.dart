// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/manage/sportCenterPage.dart';

class AdminMaintenancePage extends StatefulWidget {
  const AdminMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AdminMaintenancePage> createState() => _AdminMaintenancePageState();
}

class _AdminMaintenancePageState extends State<AdminMaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Manage your', false),
            title('Sports center', true),
            SizedBox(height: 32.0),
            Expanded(
                child: ListView.builder(
              itemCount: AdminSession.session.owns.length,
              itemBuilder: (context, index) {
                return sportCenterCard(
                    AdminSession.session.owns[index].nama,
                    AdminSession.session.owns[index].alamat,
                    AdminSession.session.owns[index].kota,
                    context, index);
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget sportCenterCard(
      String scName, String scAddress, String scCity, BuildContext context, int index) {
    return Card(
      color: Colors.black,
      child: InkWell(
        onTap: () {
          // Tp to Page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SCDetailPage(index: index),
              )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scName,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Comfortaa'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textWithIconRow(Icons.location_on, scAddress),
                  textWithIconRow(Icons.location_city, scCity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
