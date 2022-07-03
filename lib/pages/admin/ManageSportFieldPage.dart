// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/pages/admin/AddSportFieldPage.dart';
import 'package:flutter/material.dart';

class ManageSportFieldPage extends StatefulWidget {
  final SportCentre dataSC;
  final List<SportField> dataSF;

  const ManageSportFieldPage(
      {Key? key, required this.dataSC, required this.dataSF})
      : super(key: key);

  @override
  State<ManageSportFieldPage> createState() => _ManageSportFieldPageState();
}

class _ManageSportFieldPageState extends State<ManageSportFieldPage> {
  final TextEditingController _tfSearchBar = TextEditingController();

  Widget sportFieldCard(BuildContext context, SportCentre sc, SportField sf) {
    return GestureDetector(
      onTap: () {
        //EDIT SF
      },
      onLongPress: () {
        //DELETE SF
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
  void initState() {
    // TODO: implement initState
    super.initState();
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Sport Field', false),
                    title(widget.dataSC.name, true),
                  ],
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit SC'),
                ),
              ],
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSportFieldPage(dataSC: widget.dataSC,),
              ));
        },
        //elevation: 0.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
