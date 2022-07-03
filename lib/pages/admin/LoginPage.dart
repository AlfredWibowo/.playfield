// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/BottomNavigationPage.dart';
import 'package:project_ambw/pages/admin/SignUpPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _isPasswordVisible = false;

  final TextEditingController _tfEmailController = TextEditingController();
  final TextEditingController _tfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: backButton(context),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.warning_amber_outlined,
                color: Colors.black,
                size: 64,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'AUTHORIZED_ACCESS\n'
              'ONLY',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _tfEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: passwordToggleIcon(_isPasswordVisible),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _tfEmailController.text;
                String password = _tfPasswordController.text;

                //cek email exist in admin
                final docSnap = await FirebaseFirestore.instance
                    .collection("Admin")
                    .doc(email)
                    .get();

                if (docSnap.exists) {
                  Future<String> responseMsg;

                  responseMsg = AuthService.login(
                    email: email,
                    password: password,
                  );

                  String msg = await responseMsg;
                  buildSnackBar(context, msg);

                  if (msg == 'Successful') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminBottomNavigationPage(),
                      ),
                    );
                  }
                }
                else {
                  buildSnackBar(context, "Register Admin Account First");
                }
              },
              child: Text(
                'log in'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                primary: Colors.black,
                shape: roundedRectangleBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminSignUpPage(),
                    ));
              },
              child: Center(
                child: Text(
                  'create admin account ?'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
