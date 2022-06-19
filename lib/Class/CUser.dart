import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    required this.isAdmin,
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
      isAdmin: json['isAdmin'],
    );
  }

  factory UserCls.fromDocument(DocumentSnapshot doc) {
    return UserCls(
      email: doc.get('email'),
      nama: doc.get('nama'),
      alamat: doc.get('alamat'),
      noTelp: doc.get('noTelp'),
      isAdmin: doc.get('isAdmin'),
    );
  }
}
