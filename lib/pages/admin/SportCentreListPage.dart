// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/AddSportCentrePage.dart';
import 'package:project_ambw/pages/admin/ManageSportCentrePage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SportCentreListPage extends StatefulWidget {
  const SportCentreListPage({Key? key}) : super(key: key);

  @override
  State<SportCentreListPage> createState() => _SportCentreListPageState();
}

class _SportCentreListPageState extends State<SportCentreListPage> {
  final TextEditingController _tfSearchBar = TextEditingController();

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
                      builder: (context) => ManageSportCentrePage(
                        dataSC: sc, 
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
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageSportCentrePage(
                  dataSC: sc,
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
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tfSearchBar.addListener(onSearch);
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return SportCentreFirestoreDatabase.getDataByAdmin(
        AdminSession.session, _tfSearchBar.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _tfSearchBar.dispose();
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
            AdminSession.session.sportCentreId.isEmpty
                ? emptyText()
                : StreamBuilder<QuerySnapshot>(
                    stream: onSearch(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        //add to list sport centre

                        List<SportCentre> listSC = [];

                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot dsData = snapshot.data!.docs[i];

                          SportCentre sc = SportCentre.fromDocument(dsData);

                          listSC.add(sc);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSportCentrePage(),
              ));
        },
        label: Text(
          'Add New'.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
