// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CTransaksi.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:uuid/uuid.dart';

class BookingPage extends StatefulWidget {
  final int idxGedung;
  final List<String> dataListType;
  final Admin admin;

  const BookingPage(
      {Key? key, required this.idxGedung, required this.dataListType, required this.admin})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController _tfDate = TextEditingController();

  late String _dropdownFieldType;
  late List<String> _listFieldType;

  late int _dropdownStartTime;
  late int _dropdownEndTime;
  late List<int> _listTime;
  late Gedung _gedung;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listFieldType = widget.dataListType;
    _dropdownFieldType = _listFieldType[0];

    _gedung = widget.admin.owns[widget.idxGedung];
    String start = _gedung.opTime.startTime;
    String end = _gedung.opTime.endTime;
    _dropdownStartTime = int.parse(start.substring(0, 2));
    _dropdownEndTime = int.parse(end.substring(0, 2));

    _listTime = [
      for (var i = _dropdownStartTime; i <= _dropdownEndTime; i += 1) i
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: backButton(context),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title("Booking Form", true),
            SizedBox(
              height: 32,
            ),
            TextField(
              controller: _tfDate,
              decoration: InputDecoration(
                labelText: 'dd/mm/yyyy',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DecoratedBox(
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
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                      isExpanded: true,
                      value: _dropdownFieldType,
                      items: _listFieldType.map((String value) {
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
                          _dropdownFieldType = newValue!;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Time'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
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
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 16),
                            isExpanded: true,
                            value: _dropdownStartTime,
                            items: _listTime.map((int value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(fontFamily: 'Roboto'),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _dropdownStartTime = newValue!;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.remove),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
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
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 16),
                            isExpanded: true,
                            value: _dropdownEndTime,
                            items: _listTime.map((int value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(fontFamily: 'Roboto'),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _dropdownEndTime = newValue!;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String date = _tfDate.text;
                String hour = "$_dropdownStartTime-$_dropdownEndTime";

                // Add Ticket
                FieldOccupancy fieldOccupancy =
                    FieldOccupancy(hour: hour, isOccupied: true); 


                Admin adminInput = widget.admin;
                List<Field> lofAdmin = adminInput.owns[widget.idxGedung].fields;
                for(int i = 0; i < lofAdmin.length; i++) {
                  // Check if type equal
                  if (lofAdmin[i].type == _dropdownFieldType) {
                    adminInput.owns[widget.idxGedung].fields[i].occupancies.add(fieldOccupancy);
                    AdminFirestoreDatabase.editData(admin: adminInput);
                  }
                }
                buildSnackBar(context, "Tickets Reserved");
                Navigator.pop(context);
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
