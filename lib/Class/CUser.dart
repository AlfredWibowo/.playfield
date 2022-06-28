import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/class/CLapangan.dart';


class TupleTime {
  String startTime;
  String endTime;

  TupleTime({required this.startTime, required this.endTime});

  Map<String, dynamic> toJson() {
    return {
      "startTime": startTime,
      "endTime": endTime
    };
  }

  factory TupleTime.fromJson(Map<String, dynamic> json) {
    return TupleTime(
      startTime: json['starTime'], 
      endTime: json['endTime']);
   }

}

class Consumer extends UserCls {
  int saldo = 0;
  List<String> tickets = [];
  List<String> histories = [];

  Consumer({
    List<String>? ticket,
    List<String>? history,
    required String email,
    required String nama,
    required String alamat,
    required String noTelp,
    required bool isAdmin,
  }) : super(email: email,nama: nama,alamat: alamat,noTelp: noTelp,isAdmin: isAdmin) {
    if (ticket!.isNotEmpty) {
      tickets = ticket;
    } else {
      tickets = [];
    }
    if (history!.isNotEmpty) {
      histories = history;
    } else {
      histories= [];
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
      "ticket": jsonEncode(tickets),
      "history": jsonEncode(histories),
    };
  }

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
      isAdmin: json['isAdmin'],
      ticket: (jsonDecode(json['ticket']) as List<dynamic>).cast<String>(),
      history: (jsonDecode(json['history']) as List<dynamic>).cast<String>(),
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
        history: doc.get("history"));
  }
}

class Admin extends UserCls {
  List<Gedung> owns = [];
  List<String> activeTicket = [];
  Admin(
      {List<Gedung>? own,
      List<String>? activeTicket,
      required String email,
      required String nama,
      required String alamat,
      required String noTelp,
      required bool isAdmin})
      : super(
          email: email,
          nama: nama,
          alamat: alamat,
          noTelp: noTelp,
          isAdmin: true,
        ) {
    if (own!.isNotEmpty) {
      owns = own;
    } else {
      owns = [];
    }

    if (activeTicket!.isNotEmpty) {
      activeTicket = activeTicket;
    } else {
      activeTicket = [];
    }
  }

  Admin.jsonConstructor({required this.owns, required this.activeTicket, required String email,
      required String nama,
      required String alamat,
      required String noTelp,
      required bool isAdmin}):super(
          email: email,
          nama: nama,
          alamat: alamat,
          noTelp: noTelp,
          isAdmin: true,
        );

  void addTicket(String uuid) {
    activeTicket.add(uuid);
  }

  bool verifyTicket(String uuid) {
    // TODO: Verify Ticket
    // loop each _activeTicket
    // if uuid == _ticketID
    //  then true
    return true;
  }

  void addGedung(Gedung input) {
    int index = findGedungIndex(input.nama);
    if (index == -1) {
      owns.add(input);
    } else {
      // TODO: Failed insert, Duplicate Name
      print("Failed To Insert");
    }

  }

  List<String> getAllLocationName() {
    List<String> output = [];
    for(int i =0; i < owns.length; i++) {
      output.add(owns[i].nama);
    }
    return output;
  }

  int findGedungIndex(String nama) {
    for (int i =0; i< owns.length; i++) {
      if (owns[i].nama == nama) {
        return i;
      }
    }
    return -1;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "noTelp": noTelp,
      "isAdmin": isAdmin,
      "own": List<dynamic>.from(owns.map((x) => x.toJson())),
      "activeTicket": activeTicket
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        email: json['email'],
        nama: json['nama'],
        alamat: json['alamat'],
        noTelp: json['noTelp'],
        isAdmin: json['isAdmin'],
        own: List<Gedung>.from(json["own"].map((x) => Gedung.fromJson(x))),
        activeTicket: (jsonDecode(json['activeTicket']) as List<dynamic>).cast<String>()
    );
  }

  factory Admin.fromDocument(DocumentSnapshot doc) {
    List<dynamic> ownInput =  doc.get('own');
    List<Gedung> castedOI = ownInput.map((e) => Gedung(nama: e["name"], kota: e["kota"], alamat: e["alamat"], noTelp: e["noTelp"], opTime: TupleTime(startTime:e["opTime"]['startTime'],endTime: e['opTime']['endTime'] ))).toList();
    List<dynamic> ticketInput =  doc.get('activeTicket');
    List<String> castedTI = ticketInput.cast<String>();
    return Admin.jsonConstructor(
        email: doc.get('email'),
        nama: doc.get('nama'),
        alamat: doc.get('alamat'),
        noTelp: doc.get('noTelp'),
        isAdmin: doc.get('isAdmin'),
        owns: castedOI,
        activeTicket: castedTI
      );
  }
}

class Gedung {
  String nama;
  String kota;
  String alamat;
  String noTelp;
  TupleTime opTime;
  List<Field> fields = [];

  Gedung({required this.nama, required this.kota, required this.alamat, required this.noTelp,
      required this.opTime});

  Gedung.jsonConstructor({required this.nama, required this.kota, required this.alamat, required this.noTelp,
      required this.opTime, List<Field>? fields});

  Map<String, dynamic> toJson() {
    return {
      "name": nama,
      "alamat": alamat,
      "kota": kota,
      "noTelp": noTelp,
      "opTime": opTime.toJson(),
      "fields": List<dynamic>.from(fields.map((x) => x.toJson()))
    };
  }

  factory Gedung.fromJson(Map<String, dynamic> json) {
    return Gedung.jsonConstructor(
        nama: json['nama'],
        kota: json['kota'],
        alamat: json['alamat'],
        noTelp: json['noTelp'],
        opTime: TupleTime.fromJson(json['opTime']),
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x)))
    );
  }

  factory Gedung.fromDocument(DocumentSnapshot doc) {
    List<dynamic> fields = doc.get('fields');
    List<Field> fieldList = fields.map((e)  => Field(fieldID: e['fieldID'], type: e['type'], priceHour: e['priceHour'])).toList();
    return Gedung.jsonConstructor(
        nama: doc.get('nama'),
        kota: doc.get('kota'),
        alamat: doc.get('alamat'),
        noTelp: doc.get('noTelp'),
        opTime: doc.get('opTime'),
        fields: fieldList,
    );
  }

  

  List<String> getAllFieldID() {
    List<String> output = [];
    for(int i =0; i < fields.length; i++) {
      output.add(fields[i].fieldID!);
    }
    return output;
  }

}


class UserCls {
  String email;
  String nama;
  String alamat;
  String noTelp;
  bool isAdmin;

  UserCls(
      {required this.email,
      required this.nama,
      required this.alamat,
      required this.noTelp,
      required this.isAdmin});

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
        isAdmin: json['isAdmin']);
  }

  factory UserCls.fromDocument(DocumentSnapshot doc) {
    return UserCls(
        email: doc.get('email'),
        nama: doc.get('nama'),
        alamat: doc.get('alamat'),
        noTelp: doc.get('noTelp'),
        isAdmin: doc.get('isAdmin'));
  }
}
