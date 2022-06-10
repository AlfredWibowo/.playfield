// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables


import 'package:project_ambw/firebase_options.dart';
import 'package:project_ambw/pages/BottomNavigation.dart';
import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'class/CUser.dart';

String userSession = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthService.streamAuthStatus(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.active) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  //bodyText1: TextStyle(fontSize: 12),
                  bodyText2: TextStyle(fontSize: 12),
                ),
              ),
              home:
                  snapshot.data == null ? LoginPage() : BottomNavigationPage(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
