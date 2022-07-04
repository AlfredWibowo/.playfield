// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/pages/admin/AddSportFieldPage.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/pages/admin/ManageFieldPage.dart';
import 'package:project_ambw/pages/admin/deletePage.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class ManageSportCentrePage extends StatefulWidget {
  final SportCentre dataSC;

  const ManageSportCentrePage(
      {Key? key, required this.dataSC})
      : super(key: key);

  @override
  State<ManageSportCentrePage> createState() => _ManageSportCentrePageState();
}

class _ManageSportCentrePageState extends State<ManageSportCentrePage> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: backButton(context),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                appBarIconBtn(context, Icons.delete,
                    deleteSCPage(deleteCentre: widget.dataSC)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
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
                        title('Manage Sport Centre', false),
                        title(widget.dataSC.name, true),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 32),
                scCard('Address', widget.dataSC.address, context),
                const SizedBox(height: 8),
                scCardEditable(
                    'Phone Number', widget.dataSC.phoneNumber, context),
                const SizedBox(height: 8),
                scCard('City', widget.dataSC.city, context),
                const SizedBox(height: 32),
                subTitle("Fields"),
                const SizedBox(height: 16),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: SportFieldFirestoreDatabase.getDataBySportCentre(widget.dataSC),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        List<SportField> listSF = [];

                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot dsData = snapshot.data!.docs[i];
                          SportField sf = SportField.fromDocument(dsData);
                          listSF.add(sf);
                        }
                      
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listSF.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              key: Key(listSF[index].id),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ManageSportFieldPage(
                                        dataSF: listSF[index],
                                        dataSC: widget.dataSC,
                                      ),
                                    )).then((_) => setState(
                                      () {},
                                    ));
                              },
                              contentPadding: EdgeInsets.all(16.0),
                              tileColor: Colors.black,
                              title: Text(
                                listSF[index].name,
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 14.0,
                                    color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listSF[index].fieldType,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 10.0,
                                        color: Colors.white),
                                  ),
                                  textWithIconRow(
                                      Icons.monetization_on,
                                      "Rp. " +
                                          listSF[index].price.toString()),
                                ],
                              ),
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 10));
                      }
                      return progressIndicator();
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSportFieldPage(
                    dataSC: widget.dataSC,
                  ),
                )).then((_) => {setState(() {})});
          },
          //elevation: 0.0,
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 152, 173, 166),
        ),
      ),
    );
  }

  Card scCard(String title, String value, BuildContext context) {
    TextEditingController _tfController = TextEditingController();

    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
                color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
          ),
          trailing: Container(width: 0, height: 0)),
    );
  }

  Card scCardEditable(String title, String value, BuildContext context) {
    TextEditingController _tfController = TextEditingController();

    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
              color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                dialogContext = context;
                return AlertDialog(
                  insetPadding: EdgeInsets.all(24.0),
                  title: Text(
                    ('Edit ' + title).toUpperCase(),
                    style: const TextStyle(fontFamily: 'Comfortaa'),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(height: 16.0),
                            ListTile(
                              subtitle: TextField(
                                controller: _tfController,
                                decoration: InputDecoration(
                                    labelText: title,
                                    focusedBorder: outlineInputBorder(),
                                    enabledBorder: outlineInputBorder()),
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(4), // <-- Radius
                                ),
                                elevation: 0.0,
                                primary: Colors.black,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                widget.dataSC.phoneNumber = _tfController.text;
                                SportCentreFirestoreDatabase.editData(
                                    sc: widget.dataSC);
                                buildSnackBar(
                                    context, title + ' berhasil di edit');
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    )
                  ],
                );
              },
            ).then((_) => setState(() {}));
          },
          icon: const Icon(Icons.edit),
          color: Colors.grey,
        ),
      ),
    );
  }
}
