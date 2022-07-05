// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/BottomNavigationPage.dart';
import 'package:project_ambw/pages/admin/LoginPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:flutter/material.dart';

class AdminSignUpPage extends StatefulWidget {
  const AdminSignUpPage({Key? key}) : super(key: key);

  @override
  State<AdminSignUpPage> createState() => _AdminSignUpPageState();
}

class _AdminSignUpPageState extends State<AdminSignUpPage> {
  bool _isPasswordVisible = false;

  final TextEditingController _tfNameController = TextEditingController();
  final TextEditingController _tfEmailController = TextEditingController();
  final TextEditingController _tfPasswordController = TextEditingController();
  final TextEditingController _tfPhoneNumberController =
      TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _tfNameController,
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
                controller: _tfPhoneNumberController,
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
                controller: _tfAddressController,
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
                  String email = _tfEmailController.text;
                  String name = _tfNameController.text;
                  String address = _tfAddressController.text;
                  String phoneNumber = _tfPhoneNumberController.text;
      
                  Admin data = Admin(
                    notifId: [],
                    orderId: [],
                    sportCentreId: [],
                    email: email,
                    name: name,
                    address: address,
                    phoneNumber: phoneNumber,
                    profilePicture: "",
                  );
      
                  await AdminFirestoreDatabase.addData(admin: data);
      
                  Future<String> responseMsg;
      
                  responseMsg = AuthService.signUp(
                    email: _tfEmailController.text,
                    password: _tfPasswordController.text,
                  );
      
                  String msg = await responseMsg;
      
                  if (msg == 'Successful') {
                    buildSnackBar(context, "Successfully Registered");
      
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminBottomNavigationPage()));
                  }
                  else {
                    buildSnackBar(context, msg);
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
                    MaterialPageRoute(builder: (context) => AdminLoginPage()),
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
      ),
    );
  }
}
