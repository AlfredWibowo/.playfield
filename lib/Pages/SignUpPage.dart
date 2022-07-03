// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/BottomNavigation.dart';
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

  final TextEditingController _tfNameController = TextEditingController();
  final TextEditingController _tfEmailController = TextEditingController();
  final TextEditingController _tfPasswordController = TextEditingController();
  final TextEditingController _tfPhoneNumberController = TextEditingController();
  final TextEditingController _tfAddressController = TextEditingController();

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
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextField(
              controller: _tfNameController,
              style: RegisterInputStyle(),
              decoration: RegisterInputDecoration("Full Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfEmailController,
              style: RegisterInputStyle(),
              decoration: RegisterInputDecoration("Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfPasswordController,
              style: RegisterInputStyle(),
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
              controller: _tfPhoneNumberController,
              style: RegisterInputStyle(),
              decoration: RegisterInputDecoration("Phone Number"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _tfAddressController,
              style: RegisterInputStyle(),
              decoration: RegisterInputDecoration("Address"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _tfEmailController.text;
                String password = _tfPasswordController.text;
                String name = _tfNameController.text;
                String address = _tfAddressController.text;
                String phoneNumber = _tfPhoneNumberController.text;

                Consumer data = Consumer(
                  balance: 0,
                  orderId: [],
                  email: email,
                  password: password,
                  name: name,
                  address: address,
                  phoneNumber: phoneNumber,
                  profilePicture: "",
                );

                await ConsumerFirestoreDatabase.addData(consumer: data);
                Future<String> responseMsg;

                responseMsg = AuthService.signUp(
                    email: _tfEmailController.text,
                    password: _tfPasswordController.text);

                String msg = await responseMsg;
                buildSnackBar(context, msg);
                

                if (msg == 'Successful') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage()));
                }
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

  TextStyle RegisterInputStyle() {
    return TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        color: Colors.black);
  }

  InputDecoration RegisterInputDecoration(String label) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      labelText: label,
      focusedBorder: underlineInputBorder(),
      enabledBorder: underlineInputBorder(),
    );
  }
}
