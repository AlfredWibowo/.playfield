// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/BookingPage.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/storageService.dart';

class ExploreSFPage extends StatefulWidget {
  final SportCentre dataSC;
  final List<SportField> dataSF;

  const ExploreSFPage({Key? key, required this.dataSC, required this.dataSF})
      : super(key: key);

  @override
  State<ExploreSFPage> createState() => _ExploreSFPageState();
}

class _ExploreSFPageState extends State<ExploreSFPage> {
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sf.fieldPicture == ""
                ? Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.white
                  )
                : FutureBuilder<String>(
                    future: StorageService.getDownloadUrl(
                      imageName: sf.fieldPicture,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        print(snapshot.data!);
                        return imageNetwork(snapshot.data!, 100, 110);
                      }
                      return progressIndicator();
                    },
                  ),
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
                  height: 10,
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
    SportCentre sc = widget.dataSC;
    List<SportField> listSF = widget.dataSF;

    List<SportField> listSFBadminton =
        listSF.where((element) => element.fieldType == "Badminton").toList();
    List<SportField> listSFFutsal =
        listSF.where((element) => element.fieldType == "Futsal").toList();
    List<SportField> listSFBasketball =
        listSF.where((element) => element.fieldType == "Basketball").toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: backButton(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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

              //Badminton
              listSFBadminton.isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitle('Badminton'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 148,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return sportFieldCard(
                                  context, sc, listSFBadminton[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: listSFBadminton.length,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),

              //Futsal
              listSFFutsal.isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitle('Futsal'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 148,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return sportFieldCard(
                                  context, sc, listSFFutsal[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: listSFFutsal.length,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),

              //Basketball
              listSFBasketball.isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitle('Basketball'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 148,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return sportFieldCard(
                                  context, sc, listSFBasketball[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: listSFBasketball.length,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
