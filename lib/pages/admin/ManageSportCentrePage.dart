// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/UserSesssion.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/AddSportCentrePage.dart';
import 'package:project_ambw/pages/admin/ManageSportFieldPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageSportCentrePage extends StatefulWidget {
  const ManageSportCentrePage({Key? key}) : super(key: key);

  @override
  State<ManageSportCentrePage> createState() => _ManageSportCentrePageState();
}

class _ManageSportCentrePageState extends State<ManageSportCentrePage> {
  final TextEditingController _tfSearchBar = TextEditingController();

  Widget sportCentreCard(BuildContext context, SportCentre sc) {
    List<String> listFieldType = [];
    List<SportField> listSportField = [];

    return StreamBuilder<QuerySnapshot>(
      stream: SportFieldFirestoreDatabase.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData || snapshot.data != null) {
          //add to list sport field type
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            DocumentSnapshot dsData = snapshot.data!.docs[i];
            SportField sf = SportField.fromDocument(dsData);

            if (sc.sportFieldId.contains(sf.id)) {
              listFieldType.add(sf.fieldType);
              listSportField.add(sf);
            }
          }

          List<String> disctinct = listFieldType.toSet().toList();
          disctinct.sort();

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageSportFieldPage(
                      dataSC: sc,
                      dataSF: listSportField,
                    ),
                  ));
            },
            onLongPress: () {
              //DELETE SC (KLO SC HAPUS SF NYA JUGA)
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sc.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textWithIconRow(Icons.location_on, sc.address),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Row(
                        children: sportCardList(disctinct),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              sc.city,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }

        return progressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Manage your', false),
            title('Sport Centre', true),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _tfSearchBar,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: SportCentreFirestoreDatabase.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData || snapshot.data != null) {
                  //add to list sport centre where id sc in admin

                  List<SportCentre> listSC = [];

                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    DocumentSnapshot dsData = snapshot.data!.docs[i];

                    SportCentre sc = SportCentre.fromDocument(dsData);

                    if (AdminSession.session.sportCentreId.contains(sc.id)) {
                      listSC.add(sc);
                    }
                  }

                  if (listSC.isEmpty) {
                    return emptyText();
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return sportCentreCard(context, listSC[index]);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listSC.length,
                    ),
                  );
                }

                return progressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSportCentrePage(),
              ));
        },
        elevation: 0.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
