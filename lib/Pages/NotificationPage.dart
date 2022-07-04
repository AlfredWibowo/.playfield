// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/class/Notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
            title('Notification', true),
            SizedBox(
              height: 30,
            ),
            ConsumerSession.session.notifId.isEmpty
                ? emptyText()
                : StreamBuilder<QuerySnapshot>(
                    stream: NotifFirestoreDatabase.getDataByConsumer(
                        ConsumerSession.session),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        List<Notif> listNotif = [];

                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot dsData = snapshot.data!.docs[i];

                          Notif notif = Notif.fromDocument(dsData);

                          listNotif.add(notif);
                        }

                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(listNotif[index].message),
                                subtitle: Text(listNotif[index].date),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: listNotif.length,
                          ),
                        );
                      }
                      return progressIndicator();
                    }),
          ],
        ),
      ),
    );
  }
}
