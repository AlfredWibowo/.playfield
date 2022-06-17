import 'package:cloud_firestore/cloud_firestore.dart';

class LapanganCls {
  String email;
  String nama;
  String alamat;
  String kota;
  String noTelp;

  LapanganCls({
    required this.email,
    required this.nama,
    required this.alamat,
    required this.kota,
    required this.noTelp,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "alamat": alamat,
      "kota": kota,
      "noTelp": noTelp,
    };
  }

  factory LapanganCls.fromJson(Map<String, dynamic> json) {
    return LapanganCls(
      email: json['email'],
      nama: json['nama'],
      alamat: json['alamat'],
      kota: json['kota'],
      noTelp: json['noTelp'],
    );
  }

  factory LapanganCls.fromDocument(DocumentSnapshot doc) {
    return LapanganCls(
      email: doc.get('email'),
      nama: doc.get('nama'),
      alamat: doc.get('alamat'),
      kota: doc.get('kota'),
      noTelp: doc.get('noTelp'),
    );
  }
}
