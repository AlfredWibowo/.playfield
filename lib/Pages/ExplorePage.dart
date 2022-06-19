// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CKota.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/localService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<LapanganCls> _listLapangan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listKota = localService.getAllKota();

    getLapangan();
  }

  getLapangan() async {
    _listLapangan.clear();

    // final querySnapshot = await FirestoreDatabase.tbLapangan.where('kota', isEqualTo: 'Surabaya').get();

    // print(querySnapshot.size);
    // for (var doc in querySnapshot.docs) {
    //   LapanganCls lap = LapanganCls.fromDocument(doc);
    //   _listLapangan.add(lap);
    //   print(lap);
    // }

    // final querySnapshot = FirestoreDatabase.tbLapangan.where('kota', isEqualTo: 'Surabaya').snapshots();

    // print(querySnapshot.length);
    // querySnapshot
  }

  TextEditingController _tfSearchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
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
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            exploreCard('GOR Sudirman', '087853946662', 'Jl. Kertajaya Surabaya', 'Surabaya'),
            exploreCard('GOR lala', '087853946662', 'Jl. Kertajaya Surabaya', 'Bekasi'),
          ],
        ),
      ),
    );

    // Scaffold(
    //   body: ListView(
    //     children: [
    //       //dropdown kota
    //       // FutureBuilder<List<Kota>>(
    //       //   future: _listKota,
    //       //   builder: (context, snapshot) {
    //       //     if (snapshot.hasError) {
    //       //       return Text('${snapshot.error}');
    //       //     } else if (snapshot.hasData || snapshot.data != null) {
    //       //       List<Kota> isiData = snapshot.data!;
    //       //       List<String> kota = [];

    //       //       for (int i = 0; i < 30; i++) {
    //       //         if (!kota.contains(isiData[i].nama)) {
    //       //           kota.add(isiData[i].nama);
    //       //         }
    //       //       }
    //       //       print(kota);
    //       //       kota.sort();
    //       //       return DropdownButton(
    //       //         isExpanded: true,
    //       //         value: _dropdownValue,
    //       //         icon: Icon(Icons.arrow_drop_down),
    //       //         items: kota.map((String value) {
    //       //           return DropdownMenuItem(
    //       //             value: value,
    //       //             child: Text(value),
    //       //           );
    //       //         }).toList(),
    //       //         onChanged: (String? newValue) {
    //       //           setState(() {
    //       //             _dropdownValue = newValue!;
    //       //             getLapangan();
    //       //           });
    //       //         },
    //       //       );
    //       //     } else {
    //       //       return Center(
    //       //         child: CircularProgressIndicator(),
    //       //       );
    //       //     }
    //       //   },
    //       // ),
    //       //list lapangan
    //       // ListView.separated(
    //       //   itemBuilder: (context, index) {
    //       //     return ListTile(
    //       //       title: Text(_listLapangan[index].nama),
    //       //       subtitle: Text(_listLapangan[index].alamat),
    //       //     );
    //       //   },
    //       //   separatorBuilder: (context, index) {
    //       //     return Divider(
    //       //       height: 8,
    //       //     );
    //       //   },
    //       //   itemCount: _listLapangan.length,
    //       // ),
    //     ],
    //   ),
    // );
  }
}
