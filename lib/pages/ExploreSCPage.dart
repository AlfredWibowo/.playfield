// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/ExploreSFPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/localService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreSCPage extends StatefulWidget {
  const ExploreSCPage({Key? key}) : super(key: key);

  @override
  State<ExploreSCPage> createState() => _ExploreSCPageState();
}

class _ExploreSCPageState extends State<ExploreSCPage> {
  LocalService localService = LocalService();

  final TextEditingController _tfSearchBar = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tfSearchBar.addListener(onSearch);
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {

    });
    return SportCentreFirestoreDatabase.getData(_tfSearchBar.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _tfSearchBar.dispose();
  }

  Widget sportCentreCard(BuildContext context, SportCentre sc) {
    List<String> listFieldType = [];
    List<SportField> listSportField = [];

    if (sc.sportFieldId.isNotEmpty) {
      return StreamBuilder<QuerySnapshot>(
        stream: SportFieldFirestoreDatabase.getDataBySportCentre(sc),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData || snapshot.data != null) {
            //add to list sport field
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              DocumentSnapshot dsData = snapshot.data!.docs[i];
              SportField sf = SportField.fromDocument(dsData);

              listSportField.add(sf);
              listFieldType.add(sf.fieldType);
            }

            List<String> disctinct = listFieldType.toSet().toList();
            disctinct.sort();

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExploreSFPage(
                        dataSC: sc,
                        dataSF: listSportField,
                      ),
                    ));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      height: 6,
                    ),
                    textWithIconRow(Icons.phone, sc.phoneNumber),
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
    } else {
      return Container(
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
                  children: sportCardList([]),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Find your', false),
            title('playfield', true),
            title('Here', false),
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData || snapshot.data != null) {
                    //add to list
                    List<SportCentre> listSC = [];

                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot dsData = snapshot.data!.docs[i];
                      SportCentre sc = SportCentre.fromDocument(dsData);
                      listSC.add(sc);
                    }

                    if (listSC.isEmpty) {
                      return emptyText();
                    }

                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return sportCentreCard(context, listSC[index]);
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: listSC.length);
                  }

                  return progressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
