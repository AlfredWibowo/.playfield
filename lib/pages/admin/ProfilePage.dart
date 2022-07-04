// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/ResetPassword.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/storageService.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  Card profileCard(BuildContext context, String title, String value) {
    TextEditingController _tfController = TextEditingController();

    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          value,
          style:
              TextStyle(color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            // BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                // dialogContext = context;
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
                                if (title == "Name") {
                                  AdminSession.session.name =
                                      _tfController.text;
                                } else if (title == "Address") {
                                  AdminSession.session.address =
                                      _tfController.text;
                                } else if (title == "Phone Number") {
                                  AdminSession.session.phoneNumber =
                                      _tfController.text;
                                }

                                //buildSnackBar(context, "Edit ${title}");

                                AdminFirestoreDatabase.editData(
                                    admin: AdminSession.session);

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
                                Navigator.pop(context);
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
          icon: Icon(Icons.edit),
          color: Colors.grey,
        ),
      ),
    );
  }

  String imagePath = "";

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();

    imagePath = await StorageService.getDownloadUrl(
        imageName: ConsumerSession.session.profilePicture,
        isProfilePicture: true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            title('My Profile', false),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 110 * 1.5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AdminSession.session.profilePicture == ""
                        ? Icon(
                            Icons.account_box,
                            size: 100 * 1.5,
                          )
                        : FutureBuilder<String>(
                            future: StorageService.getDownloadUrl(
                              imageName: AdminSession.session.profilePicture,
                              isProfilePicture: true,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              } else if (snapshot.hasData ||
                                  snapshot.data != null) {
                                return imageNetwork(
                                  snapshot.data!,
                                  100 * 1.5,
                                  110 * 1.5,
                                );
                              }
                              return progressIndicator();
                            },
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AdminSession.session.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            textWithIconRow(Icons.email_outlined,
                                AdminSession.session.email),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg'],
                                );

                                if (result == null) {
                                  buildSnackBar(context, "No Image Selected");
                                } else {
                                  final filePath = result.files.single.path;
                                  final fileName = result.files.single.name;

                                  Future<String> responseMsg;
                                  responseMsg = StorageService.uploadImage(
                                    filePath: filePath!,
                                    fileName: fileName,
                                    isProfilePicture: true,
                                  );

                                  String msg = await responseMsg;

                                  if (msg == "Successful") {
                                    AdminSession.session.profilePicture =
                                        fileName;

                                    AdminFirestoreDatabase.editData(
                                        admin: AdminSession.session);

                                    buildSnackBar(
                                        context, "Change PP Successfull");
                                  } else {
                                    buildSnackBar(context, msg);
                                  }
                                }
                              },
                              child: Text(
                                'Change Profile Picture'.toUpperCase(),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(),
                          ));
                              },
                              child: Text(
                                'Change Password'.toUpperCase(),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            profileCard(context, 'Name', AdminSession.session.name),
            profileCard(context, 'Address', AdminSession.session.address),
            profileCard(
                context, 'Phone Number', AdminSession.session.phoneNumber),
          ],
        ),
      ),
    );
  }
}
