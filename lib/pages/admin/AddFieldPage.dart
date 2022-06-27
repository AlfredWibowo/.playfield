// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_ambw/class/CKota.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/localService.dart';

class AdminAddFieldPage extends StatefulWidget {
  const AdminAddFieldPage({Key? key}) : super(key: key);

  @override
  State<AdminAddFieldPage> createState() => _AdminAddFieldPageState();
}

enum RadioOption {
  field,
  sportCenter,
}

class _AdminAddFieldPageState extends State<AdminAddFieldPage> {
  RadioOption? _choice = RadioOption.field;

  late Widget _form;

  late Future<List<Kota>> _listKota;

  String _dropdownKota = "";

  Widget addFieldRadioBtn(String text) {
    return Row(
      children: [
        Radio<RadioOption>(
          value: text == "Field" ? RadioOption.field : RadioOption.sportCenter,
          groupValue: _choice,
          onChanged: (value) {
            setState(() {
              _choice = value;
            });
          },
        ),
        Text(text),
      ],
    );
  }

  Widget addFieldForm() {
    TextEditingController _tfLocName = TextEditingController();
    TextEditingController _tfFieldID = TextEditingController();
    TextEditingController _tfFieldType = TextEditingController();
    TextEditingController _tfPrice = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: _tfLocName,
          decoration: InputDecoration(
            labelText: 'Sport Center Name',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _tfFieldID,
          decoration: InputDecoration(
            labelText: 'Field ID',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _tfFieldType,
          decoration: InputDecoration(
            labelText: 'Field Type',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _tfPrice,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Price',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            // Get Current Admin
            Admin CurrAdmin = AdminSession.session;
            // Get Current Gedung
            int index = CurrAdmin.findGedungIndex(_tfLocName.text);
            if (index == -1) {
              // TODO: implement Error
              // Return Dialog Error Name
            } else {
              // Create Field class to input
              Field inputClass = Field(
                  fieldID: _tfFieldID.text,
                  type: _tfFieldType.text,
                  priceHour: int.parse(_tfPrice.text.toString()));
              CurrAdmin.owns[index].fields.add(inputClass);
              AdminFirestoreDatabase.editData(admin: CurrAdmin);
            }
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget addSCForm(BuildContext context) {
    TextEditingController _tfLocName = TextEditingController();
    TextEditingController _tfCity = TextEditingController();
    TextEditingController _tfAddress = TextEditingController();
    TextEditingController _tfPhoneNum = TextEditingController();
    TextEditingController _tfStartTime = TextEditingController();
    TextEditingController _tfEndTime = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: _tfLocName,
          decoration: InputDecoration(
            labelText: 'Location Name',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder<List<Kota>>(
          future: _listKota,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData || snapshot.data != null) {
              List<Kota> result = snapshot.data!;
              List<String> kota = [];

              for (int i = 0; i < 30; i++) {
                if (!kota.contains(result[i].nama)) {
                  kota.add(result[i].nama);
                }
              }
              kota.sort();

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
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                        isExpanded: true,
                        value: _dropdownKota,
                        items: kota.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontFamily: 'Roboto'),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print("new value: ${newValue}");
                          setState(() {
                            _dropdownKota = newValue!;
                          });
                          print("new value: ${_dropdownKota}");
                        }),
                  ),
                ),
              );
            }
            return progressIndicator();
          },
        ),
        SizedBox(
          height: 5,
        ),
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
        TextField(
          controller: _tfPhoneNum,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text('Operational Time'),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _tfStartTime,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: '00:00',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
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
              child: TextField(
                controller: _tfEndTime,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: '00:00',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(child: Text('Fields')),
            IconButton(
              onPressed: () {
                dialogAddNewField(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Admin CurrAdmin = AdminSession.session;
            CurrAdmin.addGedung(Gedung(
                nama: _tfLocName.text,
                kota: _tfCity.text,
                alamat: _tfAddress.text,
                noTelp: int.parse(_tfPhoneNum.text.toString()),
                opTime: TupleTime(
                    startTime: _tfStartTime.text, endTime: _tfEndTime.text)));
            AdminFirestoreDatabase.editData(admin: CurrAdmin);
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _listKota = LocalService().getAllKota();
      _form = addFieldForm();
      _dropdownKota = "Surabaya";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            title('Which one do you', false),
            Row(
              children: [
                title('want to ', false),
                title('add ', true),
                title('?', false),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            addFieldRadioBtn('Field'),
            addFieldRadioBtn('Sport Center'),
            SizedBox(
              height: 30,
            ),
            subTitle('Fill the details', false, () {}),
            SizedBox(
              height: 20,
            ),

            //_form,

            _choice == RadioOption.field ? addFieldForm() : addSCForm(context),
          ],
        ),
      ),
    );
  }
}
