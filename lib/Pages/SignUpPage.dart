// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;

  TextEditingController _tfNamaController = TextEditingController();
  TextEditingController _tfEmailController = TextEditingController();
  TextEditingController _tfPasswordController = TextEditingController();
  TextEditingController _tfNoTelpController = TextEditingController();
  TextEditingController _tfAlamatController = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: _tfNamaController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                focusedBorder: underlineInputBorder(),
                enabledBorder: underlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: underlineInputBorder(),
                enabledBorder: underlineInputBorder(),
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
                focusedBorder: underlineInputBorder(),
                enabledBorder: underlineInputBorder(),
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfNoTelpController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                focusedBorder: underlineInputBorder(),
                enabledBorder: underlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfAlamatController,
              decoration: InputDecoration(
                labelText: 'Address',
                focusedBorder: underlineInputBorder(),
                enabledBorder: underlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                Consumer data = Consumer(
                    email: _tfEmailController.text,
                    nama: _tfNamaController.text,
                    alamat: _tfAlamatController.text,
                    noTelp: _tfNoTelpController.text,
                    isAdmin: false);

                FirestoreDatabase.addDataUser(user: data);

                Future<String> responseMsg;

                responseMsg = AuthService.signUp(
                    email: _tfEmailController.text,
                    password: _tfPasswordController.text);

                String msg = await responseMsg;
                buildSnackBar(context, msg);

                if (msg == 'Successfull') {
                  Navigator.pop(context);
                }

                AuthService.logout();
              },
              child: Text(
                'sign up'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: elevatedButtonStyle(Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Center(
                child: Text(
                  'already have an account ?'.toUpperCase(),
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
