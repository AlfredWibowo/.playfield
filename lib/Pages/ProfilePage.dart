// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/TicketPage.dart';
import 'package:project_ambw/services/authService.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/storageService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              height: 110,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FutureBuilder<String>(
                      // future: StorageService.getDownloadUrl(imageName: UserSession.session.profilePicture),
                      future: StorageService.getDownloadUrl(imageName: ""),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        else if (snapshot.hasData || snapshot.data != null) {
                          String url = snapshot.data!;
                          return imageNetwork(url, 100, 110);
                        }

                        return progressIndicator();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserSession.session.nama,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          textWithIconRow(
                              Icons.email_outlined, UserSession.session.email),
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
                                responseMsg =
                                    StorageService.uploadUserProfileImage(
                                  filePath: filePath!,
                                  fileName: fileName,
                                );

                                String msg = await responseMsg;

                                if (msg == "Successful") {
                                  ConsumerFirestoreDatabase.editPP(
                                    email: UserSession.session.email,
                                    fileName: fileName,
                                  );

                                  // UserSession.session.profilePicture = fileName;

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
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            profileCard('Email', UserSession.session.email, context),
            SizedBox(height: 8),
            profileCard('Nama', UserSession.session.nama, context),
            SizedBox(height: 8),
            profileCard('Alamat', UserSession.session.alamat, context),
            SizedBox(height: 8),
            profileCard('No Telepon', UserSession.session.noTelp, context),
          ],
        ),
      ),
    );
  }

  Card profileCard(String title, String value, BuildContext context) {
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
        trailing: title == "Email"
            ? Container(
                width: 0,
                height: 0,
              )
            : IconButton(
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        actionsPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4), // <-- Radius
                                      ),
                                      elevation: 0.0,
                                      primary: Colors.black,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (title == "Nama") {
                                        UserSession.session.nama =
                                            _tfController.text;
                                        ConsumerFirestoreDatabase.editNama(
                                            email: AuthService.getEmailUser(),
                                            nama: UserSession.session.nama);
                                      } else if (title == "Alamat") {
                                        UserSession.session.alamat =
                                            _tfController.text;
                                        ConsumerFirestoreDatabase.editAlamat(
                                            email: AuthService.getEmailUser(),
                                            alamat: UserSession.session.alamat);
                                      } else if (title == "No Telepon") {
                                        UserSession.session.noTelp =
                                            _tfController.text;
                                        ConsumerFirestoreDatabase.editTelp(
                                            email: AuthService.getEmailUser(),
                                            telp: UserSession.session.noTelp);
                                      }
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
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
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
}
