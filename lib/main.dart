// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/firebase_options.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/BottomNavigation.dart';
import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/pages/ResetPassword.dart';
import 'package:project_ambw/pages/SignUpPage.dart';
import 'package:project_ambw/pages/admin/BottomNavigationPage.dart';
import 'package:project_ambw/pages/admin/LoginPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: AnimatedSplashScreen(
        duration: 500,
        splash: Icons.sports_handball,
        nextScreen: MyApp(),
        //nextScreen: BottomNavigationPage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print(AuthService.getEmailUser());
    return StreamBuilder<User?>(
      stream: AuthService.streamAuthStatus(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '.playfield',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ),
              primaryColor: Colors.black,
              //primarySwatch: Colors.blue,
              textTheme: TextTheme(
                //bodyText1: TextStyle(fontSize: 12),
                bodyText2: TextStyle(fontSize: 12),
              ),
              buttonTheme: ButtonThemeData(buttonColor: Colors.black),
            ),
            home: snapshot.data == null
                ? WelcomePage()
                : StreamBuilder<DocumentSnapshot>(
                    stream: ConsumerFirestoreDatabase.getDataByEmail(
                      AuthService.getEmailUser(),
                    ),
                    builder: (context, snapshotConsumer) {
                      if (snapshotConsumer.hasError) {
                        return Text('${snapshotConsumer.error}');
                      } else if (snapshotConsumer.hasData ||
                          snapshotConsumer.data != null) {
                        DocumentSnapshot doc = snapshotConsumer.data!;

                        if (doc.exists) {
                          return BottomNavigationPage();
                        } else {
                          return AdminBottomNavigationPage();
                        }
                      }
                      return progressIndicator();
                    },
                  ),
          );
        }
        return progressIndicator();
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: appBarIconBtn(
                context, Icons.admin_panel_settings, AdminLoginPage()),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 250),
                child: Text(
                  '.playfield',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'log in'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: elevatedButtonStyle(Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
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
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
              },
              child: Text(
                'forgot password ?'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
