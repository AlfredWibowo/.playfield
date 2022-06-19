// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:project_ambw/Class/CUserSession.dart';
import 'package:project_ambw/pages/LoginPage.dart';
import 'package:project_ambw/pages/NotificationPage.dart';
import 'package:project_ambw/pages/ProfilePage.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:flutter/material.dart';

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

Icon iconAppBar(IconData icon) {
  return Icon(
    icon,
    color: Colors.black,
    size: 32,
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

Card reservationCard(String date, String loc) {
  return Card(
    color: Colors.black,
    child: ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.all(12),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Closest Date',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox( 
                height: 4,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 64,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                loc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    ),
  );
}

Widget subTitle(String subtitle, bool seeAll, Function func) {
  if (seeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => func,
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  } else {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

Image imageNetwork(String url, double width, double height) {
  return Image.network(
    imagePath,
    fit: BoxFit.fill,
    height: height,
    width: width == 0 ? double.infinity : width,
  );
}

Row textWithIconRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 14,
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Card lastVisitCard() {
  return Card(
    color: Colors.black,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: imageNetwork(imagePath, 0, 128),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GOR Sudirman',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              textWithIconRow(Icons.phone, '087853946662'),
              textWithIconRow(Icons.location_on, 'Jl. Kertajaya Surabaya'),
              SizedBox(
                height: 30,
              ),
              textWithIconRow(Icons.calendar_today, '16/6/2022'),
            ],
          ),
        ),
      ],
    ),
  );
}

Card sportCard(String sport, Color color) {
  return Card(
    color: Colors.black,
    shape: StadiumBorder(
      side: BorderSide(color: color),
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
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

Card exploreCard(String lapangan, String noTelp, String alamat, String kota) {
  return Card(
    color: Colors.black,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8), right: Radius.zero),
          child: imageNetwork(imagePath, 126, 126),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lapangan,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              textWithIconRow(Icons.phone, noTelp),
              textWithIconRow(Icons.location_on, alamat),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  sportCard('Badminton', Colors.yellow),
                  sportCard('Basketball', Colors.red),
                  sportCard('Volley', Colors.green),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              textWithIconRow(Icons.location_city, kota.toUpperCase()),
            ],
          ),
        ),
      ],
    ),
  );
}

Icon iconStatus(int stat) {
  Icon cancle = Icon(
    Icons.cancel,
    color: Colors.red,
  );

  Icon pending = Icon(
    Icons.pause_circle,
    color: Colors.amber,
  );
  Icon active = Icon(
    Icons.play_circle,
    color: Colors.green,
  );

  switch (stat) {
    case 0:
      return cancle;
      break;
    case 1:
      return pending;
      break;
    default:
      return active;
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
      return Colors.red;
      break;
  }
}

Widget ticketCard(
    String lapangan, String noTelp, String alamat, String jenisLap, int stat) {
  return ListTile(
    shape: roundedRectangleBorder(),
    contentPadding: EdgeInsets.all(8),
    tileColor: Colors.black,
    leading: imageNetwork(imagePath, 100, 100),
    title: Text(
      lapangan,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWithIconRow(Icons.phone, noTelp),
        textWithIconRow(Icons.location_on, alamat),
        sportCard(jenisLap, sportColor(jenisLap))
      ],
    ),
    trailing: iconStatus(stat),
  );
}

Card profileCard(String title, String value) {
  return Card(
    color: Colors.black,
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        value,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: title == "Email"
          ? Container(width: 0, height: 0,)
          : Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
    ),
  );
}
