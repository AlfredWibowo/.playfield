// ignore_for_file: prefer_const_constructors

import 'package:project_ambw/class/Notification.dart';
import 'package:project_ambw/class/Order.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/User.dart';
import 'package:project_ambw/class/UserSession.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BookingPage extends StatefulWidget {
  final SportCentre dataSC;
  final SportField dataSF;

  const BookingPage({Key? key, required this.dataSC, required this.dataSF})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController _tfDate = TextEditingController();
  final TextEditingController _tfScName = TextEditingController();
  final TextEditingController _tfSfName = TextEditingController();
  final TextEditingController _tfAmount = TextEditingController();
  final TextEditingController _tfFieldType = TextEditingController();

  late int _dropdownStartTime;
  late int _dropdownEndTime;
  late List<int> _listTime;

  late int _amount;

  late SportCentre sc;
  late SportField sf;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sc = widget.dataSC;
    sf = widget.dataSF;
    String time = sf.opTime;
    List<String> timeSplited = time.split("-");

    List<String> startTime = timeSplited[0].split(":");
    List<String> endTime = timeSplited[1].split(":");

    _dropdownStartTime = int.parse(startTime[0]);
    _dropdownEndTime = int.parse(endTime[0]);

    //generate list time
    _listTime = [
      for (var i = _dropdownStartTime; i <= _dropdownEndTime; i += 1) i
    ];

    //form
    _tfScName.text = sc.name;
    _tfSfName.text = sf.name;
    _tfFieldType.text = sf.fieldType;

    int hour = _dropdownEndTime - _dropdownStartTime;
    _amount = hour * sf.price;
    _tfAmount.text = "Rp. $_amount";

    formatDate();
  }

  void formatDate() {
    //date
    var formatter = DateFormat("dd/MM/yyyy");
    String formattedDate = formatter.format(selectedDate);
    _tfDate.text = formattedDate;
  }

  void calculateAmount() {
    int hour = _dropdownEndTime - _dropdownStartTime;
    _amount = hour * sf.price;
    _tfAmount.text = "Rp. ${_amount}";
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(_listTime);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left:16.0),
          child: backButton(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title("Booking Form", true),
              SizedBox(
                height: 30,
              ),
      
              //Sc Name
              TextField(
                controller: _tfScName,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: outlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
      
              //Sf Name
              TextField(
                controller: _tfSfName,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: outlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
      
              //Field type
              TextField(
                controller: _tfFieldType,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: outlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
      
              //Date
              TextField(
                controller: _tfDate,
                decoration: InputDecoration(
                  labelText: 'dd/mm/yyyy',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
      
              Column(
                children: [
                  //dropdown time
                  Row(
                    children: [
                      Text('Time'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 14.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isDense: true,
                                  style: TextStyle(
                                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                                  isExpanded: true,
                                  value: _dropdownStartTime,
                                  items: _listTime.map((int value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value.toString(),
                                        style: TextStyle(fontFamily: 'Roboto,', color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _dropdownStartTime = newValue!;
                                      calculateAmount();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.remove),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 14.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isDense: true,
                                  style: TextStyle(
                                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                                  isExpanded: true,
                                  value: _dropdownEndTime,
                                  items: _listTime.map((int value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value.toString(),
                                        style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _dropdownEndTime = newValue!;
                                      calculateAmount();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
      
                  //Amount
                  TextField(
                    controller: _tfAmount,
                    readOnly: true,
                    enabled: false,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: outlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
      
                  //submit btn
                  ElevatedButton(
                  onPressed: () async {
                    if (ConsumerSession.session.balance < _amount) {
                      buildSnackBar(context, "Balance is not Enough");
                    }
                    else if (_dropdownEndTime < _dropdownStartTime) {
                      buildSnackBar(context, "Invalid Time");
                    } 
                    else {
                      String orderId = Uuid().v4();
                      String date = _tfDate.text;
                      String time =
                          "${_dropdownStartTime}:00-${_dropdownEndTime}:00";
                      int amount = _amount;

                      Order order = Order(
                        id: orderId,
                        date: date,
                        time: time,
                        amount: amount,
                        status: 0,
                        consumer: ConsumerSession.session,
                        sportCentre: sc,
                        sportField: sf,
                      );

                      //add id to admin
                      Admin admin = Admin(
                        notifId: [],
                        orderId: [],
                        sportCentreId: [],
                        email: "",
                        name: "",
                        address: "",
                        phoneNumber: "",
                        profilePicture: "",
                      );

                      await AdminFirestoreDatabase.tbAdmin
                          .where("sportCentreId", arrayContains: sc.id)
                          .get()
                          .then((value) {
                        DocumentSnapshot dsAdmin = value.docs.first;
                        admin = Admin.fromDocument(dsAdmin);
                      });
                      admin.orderId.add(order.id);

                      //add notif to admin
                      String notifId = Uuid().v4();
                      String notifMsg =
                          "${ConsumerSession.session.name} booking ${sc.name} ${sf.fieldType} (${sf.name})";
                      var formatter = DateFormat("dd/MM/yyyy");
                      String formattedDate = formatter.format(DateTime.now());
                      Notif notif = Notif(
                          id: notifId, date: formattedDate, message: notifMsg, isRead: false);
                      admin.notifId.add(notif.id);

                      AdminFirestoreDatabase.editData(admin: admin);

                      //add notif to db
                      NotifFirestoreDatabase.addData(notif: notif);

                      //add id to consumer
                      ConsumerSession.session.balance -= _amount; 
                      ConsumerSession.session.orderId.add(order.id);
                      ConsumerFirestoreDatabase.editData(
                          consumer: ConsumerSession.session);

                      //add order to table order
                      OrderFirestoreDatabase.addData(order: order);

                      buildSnackBar(context, 'Booking Successful');

                      Navigator.pop(context);
                    }
                  },
                    child: Text(
                      'book'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.black,
                      shape: roundedRectangleBorder(),
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
