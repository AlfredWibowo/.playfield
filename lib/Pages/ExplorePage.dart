// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> _listKota = [
    'Surabaya',
    'Bali',
    'Bandung',
    'Batu',
    'Ambon',
  ];

  final List<String> _listLapanganSurabaya = [
    'Koni',
    'Araya',
  ];

  String _dropdownValue = 'Surabaya';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        DropdownButton(
          isExpanded: true,
          value: _dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          items: _listKota.map((String kota) {
            return DropdownMenuItem(
                value: kota,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(kota),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _dropdownValue = newValue!;
            });
          },
        ),

        Expanded(
          child: ListView.builder(
            itemCount: _listLapanganSurabaya.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(_listLapanganSurabaya[index]),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
