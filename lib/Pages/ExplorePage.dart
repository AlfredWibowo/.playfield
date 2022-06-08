// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:aplikasi_booking_lapangan_online/class/CKota.dart';
import 'package:aplikasi_booking_lapangan_online/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  LocalService localService = LocalService();
  late Future<List<Kota>> _listKota;

  String _dropdownValue = 'Surabaya';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listKota = localService.getAllKota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<List<Kota>>(
              future: _listKota,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData || snapshot.data != null) {
                  List<Kota> isiData = snapshot.data!;
                  List<String> kota = [];
                  
                  // isiData.forEach((element) {
                  //   if (!kota.contains(element.nama)) {
                  //     kota.add(element.nama);
                  //   }
                  // });
                  
                  for (int i = 0; i < 30; i++) {
                    if(!kota.contains(isiData[i].nama)) {
                      kota.add(isiData[i].nama);
                    }
                  }
                  print(kota);
                  kota.sort();
                  return DropdownButton(

                    isExpanded: true,
                    value: _dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    items: kota.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
