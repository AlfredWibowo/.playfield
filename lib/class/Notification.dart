import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  String id;
  String date;
  String message;

  Notif({
    required this.id,
    required this.date,
    required this.message,
  });

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json["id"],
      date: json["date"],
      message: json["message"],
    );
  }

  factory Notif.fromDocument(DocumentSnapshot doc) {
    return Notif(
      id: doc.get("id"),
      date: doc.get("date"),
      message: doc.get("message"),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "date": date,
      "message": message,
    };
  }
}
