import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class deleteSCPage extends StatefulWidget {
  final int index;
  const deleteSCPage({Key? key, required this.index}) : super(key: key);

  @override
  State<deleteSCPage> createState() => _deleteSCPageState();
}

class _deleteSCPageState extends State<deleteSCPage> {
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
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Center(
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.black,
                  size: 64,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'ARE YOU SURE',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () { 
                        AdminSession.session.owns.removeAt(widget.index);
                        AdminFirestoreDatabase.editData(admin: AdminSession.session);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'SURE THING'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.black,
                        shape: roundedRectangleBorder(),
                      )),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'NAH'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      primary: Colors.white,
                      
                    ),
                  )
                ],
              )
            ])));
  }
}
