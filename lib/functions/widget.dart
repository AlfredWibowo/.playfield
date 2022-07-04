// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/City.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

IconButton backButton(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(
      Icons.arrow_back_ios,
      color: Colors.grey,
    ),
  );
}

UnderlineInputBorder underlineInputBorder() {
  return UnderlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  );
}

RoundedRectangleBorder roundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: Colors.black),
  );
}

ButtonStyle elevatedButtonStyle(Color color) {
  return ElevatedButton.styleFrom(
    minimumSize: Size.fromHeight(50),
    primary: color,
    shape: roundedRectangleBorder(),
  );
}

Icon passwordToggleIcon(bool _isPasswordVisible) {
  return Icon(
    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
    color: Colors.black,
  );
}

Icon appBarIcon(IconData icon) {
  return Icon(
    icon,
    color: Colors.black,
    size: 32,
  );
}

IconButton appBarIconBtn(BuildContext context, IconData icon, Widget page) {
  if (icon == Icons.logout) {
    return IconButton(
      onPressed: () {
        AuthService.logout();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      icon: appBarIcon(icon),
    );
  }
  return IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    icon: appBarIcon(icon),
  );
}

BottomNavigationBarItem bottomNavigationBarItem(Icon icon, String label) {
  return BottomNavigationBarItem(
    icon: icon,
    label: label,
  );
}

Text title(String text, bool bold) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 26,
      color: Colors.black,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w300,
    ),
  );
}

Widget subTitle(String subtitle) {
  return Text(
    subtitle,
    style: TextStyle(
      fontSize: 20,
      fontFamily: 'Comfortaa',
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  );
}

Image imageNetwork(String url, double width, double height) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    height: height,
    width: width == 0 ? double.infinity : width,
  );
}

Row textWithIconRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.grey,
        size: 12,
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Card sportCard(String sport, Color color) {
  return Card(
    color: Colors.black,
    shape: StadiumBorder(
      side: BorderSide(color: color, width: 2.0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 12.0),
      child: Text(
        sport,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    ),
  );
}

List<Widget> sportCardList(List<String> fieldType) {
  List<Widget> listCard = [];

  for (var type in fieldType) {
    listCard.add(sportCard(type, sportColor(type)));
  }

  return listCard;
}

Icon iconStatus(int stat) {
  Icon waitting = Icon(Icons.circle, color: Colors.yellow);
  Icon active = Icon(Icons.circle, color: Colors.green);
  Icon rejected = Icon(Icons.circle, color: Colors.red);
  Icon used = Icon(Icons.circle, color: Colors.grey);

  switch (stat) {
    case 0:
      return waitting;
      break;
    case 1:
      return active;
      break;
    case 2:
      return rejected;
      break;
    default:
      return used;
      break;
  }
}

Color sportColor(String sport) {
  switch (sport) {
    case "Badminton":
      return Colors.yellow;
      break;
    case "Basketball":
      return Colors.red;
      break;
    default:
      return Colors.green;
      break;
  }
}

Center progressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget addFieldBtn() {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business,
          ),
          SizedBox(
            height: 5,
          ),
          Text('sport\ncentre'.toUpperCase())
        ],
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromHeight(100),
      ),
    ),
  );
}

Widget addSportCenterForm() {
  return Column(
    children: [
      TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          labelText: 'Location Name',
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
      SizedBox(
        height: 20,
      ),
      ElevatedButton(
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
    ],
  );
}

Widget emptyText() {
  return Container(
    height: 300,
    child: Center(
      child: Text(
        'Well, There is Nothing Here',
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Comfortaa',
          fontSize: 16,
        ),
      ),
    ),
  );
}
