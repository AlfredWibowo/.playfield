import 'package:flutter/material.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class deleteSCPage extends StatefulWidget {
  final SportCentre deleteCentre;
  const deleteSCPage({Key? key, required this.deleteCentre}) : super(key: key);

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
                    fontFamily: 'Comfortaa',
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
                        SportCentreFirestoreDatabase.deleteData(sc: widget.deleteCentre);
                        AdminSession.session.sportCentreId.remove(widget.deleteCentre.id);
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

class deleteSFPage extends StatefulWidget {
  final SportField deleteSF;
  final SportCentre dataSC;
  const deleteSFPage({Key? key, required this.deleteSF, required this.dataSC}) : super(key: key);

  @override
  State<deleteSFPage> createState() => _deleteSFPageState();
}

class _deleteSFPageState extends State<deleteSFPage> {
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
                    fontFamily: 'Comfortaa',
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
                        SportFieldFirestoreDatabase.deleteData(sf: widget.deleteSF);
                        widget.dataSC.sportFieldId.remove(widget.deleteSF.id);
                        SportCentreFirestoreDatabase.editData(sc: widget.dataSC);
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