// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CKota.dart';
import 'package:project_ambw/class/CLapangan.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/authService.dart';

import 'package:flutter/material.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

IconButton backButton(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(
      Icons.arrow_back_ios,
      color: Colors.black,
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
    borderRadius: BorderRadius.circular(6),
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
            fontFamily: 'Comfortaa',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () => func,
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
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
        fontFamily: 'Comfortaa',
        color: Colors.black,
        fontWeight: FontWeight.w500,
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
    BuildContext context, String lapangan, String noTelp, String alamat, String jenisLap, int stat) {
  return ListTile(
    onTap: () {
      dialogTicket(context, lapangan);
    },
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
          ? Container(
              width: 0,
              height: 0,
            )
          : Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
    ),
  );
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

Widget ticketQRCode(String uuid, double size) {
  return Center(
    child: QrImage(
      data: uuid,
      version: QrVersions.auto,
      size: size,
      gapless: false,
    ),
  );
}
