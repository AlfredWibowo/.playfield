// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CKota.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/localService.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  LocalService localService = LocalService();
  late Future<List<Kota>> _listKota;

  String _dropdownValue = 'Surabaya';
  List<Field> _listLapangan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listKota = localService.getAllKota();
  }

  TextEditingController _tfSearchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Find your', false),
            title('playfield,', true),
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

            StreamBuilder<QuerySnapshot>(
              stream: AdminFirestoreDatabase.getData(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                else if (snapshot.hasData || snapshot.data != null) {
                  
                  List<Admin> listAdmin = [];
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    DocumentSnapshot dsData = snapshot.data!.docs[i];
                    Admin tmp = Admin.fromDocument(dsData);
                    listAdmin.add(tmp);
                  }

                  List<Gedung> listGedung = [];
                  for (var admin in listAdmin) {
                    for (var gedung in admin.owns) {
                      listGedung.add(gedung);
                    }
                  };

                  return Expanded(
                    child: ListView.separated(
                      itemCount: listGedung.length,
                      itemBuilder: (context, index) {
                        return exploreCard(context, index, listAdmin[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  );
                }
                return progressIndicator();
              })
            )
            
          ],
        ),
      ),
    );
  }
}
