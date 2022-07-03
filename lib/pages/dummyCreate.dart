// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/class/UserSesssion.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DummyCreatePage extends StatefulWidget {
  const DummyCreatePage({Key? key}) : super(key: key);

  @override
  State<DummyCreatePage> createState() => _DummyCreatePageState();
}

class _DummyCreatePageState extends State<DummyCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  String uuid = Uuid().v4();
                  var sc = SportCentre(
                    id: uuid,
                    name: "GOR Araya",
                    address: "Jl. Galaxi Bumi Permai No.1",
                    city: "Surabaya",
                    phoneNumber: "0857-3317-0825",
                    sportFieldId: [],
                  );

                  SportCentreFirestoreDatabase.addData(sc: sc);
                },
                child: Text("create sport centre")),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  String uuid = Uuid().v4();
                  var sf = SportField(
                    id: uuid,
                    name: "A1",
                    opTime: "10:00-18:00",
                    fieldType: "Futsal",
                    price: 80000,
                    fieldPicture: "",
                  );

                  SportFieldFirestoreDatabase.addData(sf: sf);
                },
                child: Text("create sport field")),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  String uuid = Uuid().v4();
                  var order = Order(
                    id: uuid,
                    date: "06/30/2022",
                    time: "10:00-12:00",
                    amount: 0,
                    status: 0,
                    consumer: Consumer(
                        balance: 0,
                        orderId: [],
                        email: "lala@gmail.com",
                        password: "lala@gmail.com",
                        name: "lala",
                        address: "Jl. lala",
                        phoneNumber: "1234567890",
                        profilePicture: ""),
                    sportCentre: SportCentre(
                        id: "1234567",
                        name: "sc coba",
                        address: "Jl. sc",
                        city: "Surabaya",
                        phoneNumber: "0857-3317-0825",
                        sportFieldId: []),
                    sportField: SportField(
                        id: "123456",
                        name: "B1",
                        opTime: "00:00-23:59",
                        fieldType: "Badminton",
                        price: 50000,
                        fieldPicture: ""),
                  );
                  OrderFirestoreDatabase.addData(order: order);
                },
                child: Text("create order")),
            SizedBox(
              height: 30,
            ),
            // StreamBuilder<DocumentSnapshot>(
            //   stream: OrderFirestoreDatabase.getDataById(
            //       "ec15e4ba-1a7f-4abb-856a-e79c2307b44d"),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     } else if (snapshot.hasData || snapshot.data != null) {
            //       DocumentSnapshot dsData = snapshot.data!;
            //       Order data = Order.fromDocument(dsData);
            //       return Text("${data.consumer.email}");
            //     }
            //     return progressIndicator();
            //   },
            // )

            SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: () async {
                //add id to admin
                Admin admin = Admin(
                    orderId: [],
                    sportCentreId: [],
                    email: "",
                    password: "",
                    name: "",
                    address: "",
                    phoneNumber: "",
                    profilePicture: "");
                await AdminFirestoreDatabase.tbAdmin
                    .where("sportCentreId", arrayContains: "")
                    .get()
                    .then((value) {
                  DocumentSnapshot dsAdmin = value.docs.first;
                  admin = Admin.fromDocument(dsAdmin);
                });

                print(admin.email);
              },
              child: Text("check"),
            ),

            SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: () {
                print(ConsumerSession.session.email);
                // ConsumerSession.session.name = "Alfred Wibowo";
                // ConsumerFirestoreDatabase.editData(consumer: ConsumerSession.session);
              },
              child: Text("Update consumer"),
            ),
          ],
        ),
      ),
    );
  }
}
