import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import 'CLapangan.dart';


class Consumer extends UserCls {
  int saldo = 0;
  List<String> tickets = [];
  List<String> histories = [];

  Consumer({List<String>? ticket, List<String>? history, required String email, required String nama, required String alamat, required String noTelp, required bool isAdmin}) : super(email: email, nama: nama, alamat: alamat, noTelp: noTelp, isAdmin: isAdmin)
  {
    if (ticket!.isNotEmpty) {
      tickets = ticket;
    } else {
      tickets = [];
    }
    if (history!.isNotEmpty) {
      histories = history;
    } else {
      histories = [];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp,
      "isAdmin": isAdmin,
      "ticket": tickets, 
      "history": histories,
    };
  }

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
      isAdmin: json['isAdmin'],
      ticket: json['ticket'], 
      history: json['history'],
    );
  }

  factory Consumer.fromDocument(DocumentSnapshot doc) {
    return Consumer(
      email: doc.get('email'),
      nama: doc.get('nama'),
      alamat: doc.get('alamat'),
      noTelp: doc.get('noTelp'),
      isAdmin: doc.get('isAdmin'),
      ticket: doc.get('ticket'),
      history: doc.get("history")
    );
  }

}

class Admin extends UserCls {
  List<Gedung> _owns = [];
  List<String> _activeTicket = [];
  Admin({List<Gedung>? own, List<String>? activeTicket, required String email, required String nama, required String alamat, required String noTelp, required bool isAdmin}) : super(email: email, nama: nama, alamat: alamat, noTelp: noTelp, isAdmin: true)
  {
    if(own!.isNotEmpty) {
      _owns = own;
    } else {
      _owns = [];
    }

    if(activeTicket!.isNotEmpty) {
      _activeTicket = activeTicket;
    } else {
      _activeTicket = [];
    }

  }

  void addTicket(String uuid) {
    _activeTicket.add(uuid);
  }

  bool verifyTicket(String uuid) { 
    // loop each _activeTicket
    // if uuid == _ticketID
    //  then true
    return true;
  }

  void addGedung(Gedung input) {
    _owns.add(input);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp,
      "isAdmin": isAdmin,
      "own": _owns,
      "activeTicket": _activeTicket
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
      isAdmin: json['isAdmin'],
      own: json['own'],
      activeTicket: json['activeTicket']
    );
  }

  factory Admin.fromDocument(DocumentSnapshot doc) {
    return Admin(
      email: doc.get('email'),
      nama: doc.get('nama'),
      alamat: doc.get('alamat'),
      noTelp: doc.get('noTelp'),
      isAdmin: doc.get('isAdmin'),
      own: doc.get('own'),
      activeTicket: doc.get('activeTicket')
    );
  }

}

class Gedung {
  int? _gedungID;
  String? _name;
  String? _city;
  String? _address;
  int? _phoneNumber;
  Tuple2<int,int>? _opTime;
  List<Field> _fields = [];
  
  Gedung(int GID, String name, String city, String address, int pNumber, Tuple2<int,int> opTime){
    _gedungID = GID;
    _name = name;
    _city = city;
    _address = address;
    _phoneNumber = pNumber;
    _opTime = opTime;
  }
  
  void addField(Field input) {
    _fields.add(input);    
  }



}

class UserCls {
  String email;
  String nama;
  String alamat;
  String noTelp;
  bool isAdmin;

  UserCls({
    required this.email,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    required this.isAdmin
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp,
      "isAdmin": isAdmin
    };
  }

  factory UserCls.fromJson(Map<String, dynamic> json) {
    return UserCls(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
      isAdmin: json['isAdmin']
    );
  }

  factory UserCls.fromDocument(DocumentSnapshot doc) {
    return UserCls(
      email: doc.get('email'),
      nama: doc.get('nama'),
      alamat: doc.get('alamat'),
      noTelp: doc.get('noTelp'),
      isAdmin: doc.get('isAdmin')
    );
  }
}
