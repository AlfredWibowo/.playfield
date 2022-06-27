// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

void buildSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void dialogAddNewField(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('add new field'.toUpperCase(), true),
            Text(
              'Add field based on your current sport center',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(),
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
              controller: TextEditingController(),
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
              controller: TextEditingController(),
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
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
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
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Colors.white,
                    shape: roundedRectangleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void dialogTicket(BuildContext context, String uuid) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title('ticket qr code'.toUpperCase(), true),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              child: QrImage(
                data: uuid,
                version: QrVersions.auto,
                size: 30,
                gapless: false,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Colors.white,
                    shape: roundedRectangleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
