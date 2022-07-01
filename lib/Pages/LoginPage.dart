// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/pages/BottomNavigation.dart';
import 'package:project_ambw/pages/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  final TextEditingController _tfEmailController = TextEditingController();
  final TextEditingController _tfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: backButton(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

                //cek email exist in consumer
                final docSnap = await FirebaseFirestore.instance
                    .collection("Consumer")
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
                        builder: (context) => BottomNavigationPage(),
                      ),
                    );
                  }
                }
                else {
                  buildSnackBar(context, "Register Consumer Account First");
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
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Center(
                child: Text(
                  'dont have an account ?'.toUpperCase(),
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
