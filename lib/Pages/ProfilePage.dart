// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email"),
                IconButton(onPressed: null, icon: Icon(Icons.edit), iconSize: 24,)
              ],
            ),
            TextField(
              enabled: false,
              readOnly: true,
              controller: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Password"),
                IconButton(onPressed: null, icon: Icon(Icons.edit), iconSize: 24,)
              ],
            ),
            TextField(
              enabled: false,
              readOnly: true,
              controller: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nomor Telepon"),
                IconButton(onPressed: null, icon: Icon(Icons.edit), iconSize: 24,)
              ],
            ),
            TextField(
              enabled: false,
              readOnly: true,
              controller: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Alamat"),
                IconButton(onPressed: null, icon: Icon(Icons.edit), iconSize: 24,)
              ],
            ),
            TextField(
              enabled: false,
              readOnly: true,
              controller: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
