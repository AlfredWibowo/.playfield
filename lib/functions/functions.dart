// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';

//snackbar
void buildSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              SizedBox(width: 10,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'cancle'.toUpperCase(),
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
