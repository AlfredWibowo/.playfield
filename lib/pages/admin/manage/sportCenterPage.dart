import 'package:flutter/material.dart';
import 'package:project_ambw/class/CUser.dart';
import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/BottomNavigation.dart';
import 'package:project_ambw/pages/admin/manage/deletePage.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class SCDetailPage extends StatefulWidget {
  final int index;
  const SCDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  State<SCDetailPage> createState() => _SCDetailPageState();
}

class _SCDetailPageState extends State<SCDetailPage> {
  List<Gedung> currGList = AdminSession.session.owns;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: backButton(context),
          ),
          actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children:[
                      appBarIconBtn(context, Icons.delete, deleteSCPage(index: widget.index)),
                    ],
                  ),
                )
              ],
        ),
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              title('Manage Sport Center', false),
              title(currGList[widget.index].nama, true),
              const SizedBox(height: 32),
              scCard('Address', currGList[widget.index].alamat, context),
              const SizedBox(height: 8),
              scCardEditable(
                  'Phone Number', currGList[widget.index].noTelp, context),
              const SizedBox(height: 8),
              scCard('City', currGList[widget.index].kota, context),
              const SizedBox(height: 24),
              subTitle("Fields", false, (){}),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                    itemCount: currGList[widget.index].fields.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        tileColor: Colors.black,
                        title: Text(
                            currGList[widget.index].fields[index].fieldID!, style: TextStyle(fontFamily: 'Comfortaa', fontSize: 14.0, color: Colors.white),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currGList[widget.index].fields[index].type!, style: TextStyle(fontFamily: 'Roboto', fontSize: 10.0, color: Colors.white),),
                            textWithIconRow(Icons.monetization_on, "Rp. " + currGList[widget.index]
                                .fields[index]
                                .priceHour!
                                .toString()),
                          ],
                        ),
                      );
                    })),
              )
            ],
          ),
        ));
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
                                currGList[widget.index].noTelp =
                                    _tfController.text;
                                AdminSession.session.owns = currGList;
                                AdminFirestoreDatabase.editData(
                                    admin: AdminSession.session);
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
