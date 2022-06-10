// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = true;

  TextEditingController _tfNamaController = TextEditingController();
  TextEditingController _tfEmailController = TextEditingController();
  TextEditingController _tfPasswordController = TextEditingController();
  TextEditingController _tfNoTelpController = TextEditingController();
  TextEditingController _tfAlamatController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.all(48),
        child: Column(
          children: [
            TextField(
              controller: _tfNamaController,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            TextField(
              controller: _tfEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _tfPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: _isPasswordVisible,
            ),
            TextField(
              controller: _tfNoTelpController,
              decoration: InputDecoration(
                labelText: 'No Telp',
              ),
            ),
            TextField(
              controller: _tfAlamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () async {
                UserCls data = UserCls(
                    email: _tfEmailController.text,
                    nama: _tfNamaController.text,
                    alamat: _tfAlamatController.text,
                    noTelp: _tfNoTelpController.text);
                    
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
                'Sign Up',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
