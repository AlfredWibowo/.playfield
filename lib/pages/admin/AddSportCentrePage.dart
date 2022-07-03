// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aplikasi_booking_lapangan_online/class/City.dart';
import 'package:aplikasi_booking_lapangan_online/class/SportCentre.dart';
import 'package:aplikasi_booking_lapangan_online/class/UserSesssion.dart';
import 'package:aplikasi_booking_lapangan_online/functions/widget.dart';
import 'package:aplikasi_booking_lapangan_online/services/dbFirestore.dart';
import 'package:aplikasi_booking_lapangan_online/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddSportCentrePage extends StatefulWidget {
  const AddSportCentrePage({Key? key}) : super(key: key);

  @override
  State<AddSportCentrePage> createState() => _AddSportCentrePageState();
}

class _AddSportCentrePageState extends State<AddSportCentrePage> {
  final TextEditingController _tfName = TextEditingController();
  final TextEditingController _tfAddress = TextEditingController();
  final TextEditingController _tfPhoneNumber = TextEditingController();

  late String _dropdownCity;
  late Future<List<City>> _listCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _listCity = LocalService().getAllKota();
      _dropdownCity = "Surabaya";
    });
  }

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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            title('Add', false),
            title('New Sport Centre', true),
            SizedBox(
              height: 30,
            ),

            //Name SC
            TextField(
              controller: _tfName,
              decoration: InputDecoration(
                labelText: 'Name',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //Address SC
            TextField(
              controller: _tfAddress,
              decoration: InputDecoration(
                labelText: 'Address',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //Phone Number SC
            TextField(
              controller: _tfPhoneNumber,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //Dropdown City
            FutureBuilder<List<City>>(
              future: _listCity,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData || snapshot.data != null) {
                  List<City> data = snapshot.data!;
                  List<String> listCity = [];

                  //asumsi 20 kota yang diambil
                  for (var i = 0; i < 20; i++) {
                    if (!listCity.contains(data[i].name)) {
                      listCity.add(data[i].name);
                    }
                  }
                  listCity.sort();

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 14.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isDense: true,
                          focusColor: Colors.transparent,
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                          isExpanded: true,
                          value: _dropdownCity,
                          items: listCity.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontFamily: 'Roboto'),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _dropdownCity = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }

                return progressIndicator();
              },
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                String id = Uuid().v4();
                String name = _tfName.text;
                String address = _tfAddress.text;
                String city = _dropdownCity;
                String phoneNumber = _tfPhoneNumber.text;

                //add sc
                SportCentre sc = SportCentre(
                  id: id,
                  name: name,
                  address: address,
                  city: city,
                  phoneNumber: phoneNumber,
                  sportFieldId: [],
                );
                SportCentreFirestoreDatabase.addData(sc: sc);

                //input id into admin list id sc
                AdminSession.session.sportCentreId.add(id);
                AdminFirestoreDatabase.editData(admin: AdminSession.session);

              },
              child: Text(
                'submit'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                primary: Colors.black,
                shape: roundedRectangleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
