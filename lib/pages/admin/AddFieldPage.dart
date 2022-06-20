// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_ambw/functions/widget.dart';

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

  Widget addFieldRadioBtn(String text) {
    return Row(
      children: [
        Radio<RadioOption>(
          value: text == "Field" ? RadioOption.field : RadioOption.sportCenter,
          groupValue: _choice,
          onChanged: (value) {
            setState(() {
              _choice = value;
              if (text == 'Field') {
                _form = addFieldForm(context);
              } else {
                _form = addSportCenterForm();
              }
            });
          },
        ),
        Text(text),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _form = addFieldForm(context);
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
            _form,
          ],
        ),
      ),
    );
  }
}