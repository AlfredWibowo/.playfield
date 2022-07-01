// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/BookingPage.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreSFPage extends StatefulWidget {
  final SportCentre dataSC;
  final List<SportField> dataSF;

  const ExploreSFPage({Key? key, required this.dataSC, required this.dataSF})
      : super(key: key);

  @override
  State<ExploreSFPage> createState() => _ExploreSFPageState();
}

class _ExploreSFPageState extends State<ExploreSFPage> {
  final TextEditingController _tfSearchBar = TextEditingController();

  Widget sportFieldCard(BuildContext context, SportCentre sc, SportField sf) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingPage(dataSC: sc, dataSF: sf),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            imageNetwork(imagePath, 100, 100),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.dataSC.name} (${sf.name})",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                textWithIconRow(Icons.price_change, "Rp. ${sf.price}"),
                textWithIconRow(Icons.alarm, "Pk. ${sf.opTime}"),
                SizedBox(
                  height: 20,
                ),
                sportCard(sf.fieldType, sportColor(sf.fieldType)),
              ],
            ),
          ],
        ),
      ),
    );
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
            title('Find your', false),
            title('playfield', true),
            title('Here', false),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _tfSearchBar,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: // return ListView.separated(
                  //   itemBuilder:(context, index) {
                  //     return sportFieldCard(context, listSF[index]);
                  //   },
                  //   separatorBuilder: (context, index) => Divider(),
                  //   itemCount: listSF.length
                  // );

                  Wrap(
                direction: Axis.horizontal,
                spacing: 32,
                runSpacing: 32,
                children: [
                  for (var sf in widget.dataSF)
                    sportFieldCard(context, widget.dataSC, sf)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
