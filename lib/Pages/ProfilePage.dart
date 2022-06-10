// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/main.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _tfProfileEmail = TextEditingController();
  TextEditingController _tfProfilePassword = TextEditingController();
  TextEditingController _tfProfileNomorTelp = TextEditingController();
  TextEditingController _tfProfileAlamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tbUser')
              .doc(AuthService.getEmail())
              .snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot.data!.get("nama"));
              _tfProfileEmail.text = snapshot.data!.get("email");
              _tfProfileAlamat.text = snapshot.data!.get("alamat");
              _tfProfileNomorTelp.text = snapshot.data!.get("noTelp");
              _tfProfilePassword.text = "*Not yet implemented";

              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email"),
                      ],
                    ),
                    tfShowDetails(_tfProfileEmail),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Password"),
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.edit),
                          iconSize: 24,
                        )
                      ],
                    ),
                    tfShowDetails(_tfProfilePassword),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nomor Telepon"),
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.edit),
                          iconSize: 24,
                        )
                      ],
                    ),
                    tfShowDetails(_tfProfileNomorTelp),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Alamat"),
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.edit),
                          iconSize: 24,
                        )
                      ],
                    ),
                    tfShowDetails(_tfProfileAlamat),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            );
          }),
    );
  }

  Widget tfShowDetails(TextEditingController controller) {
    return TextField(
      enabled: false,
      readOnly: true,
      controller: controller,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        
        border: OutlineInputBorder(),
      ),
    );
  }
}
