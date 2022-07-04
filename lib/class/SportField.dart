import 'package:cloud_firestore/cloud_firestore.dart';

class SportField {
  String id;
  String name; //(A1, B1, C1)
  String opTime; //(00:00-23:59)
  String fieldType; //(Badminton, Futsal, Basketball)
  num price;
  String fieldPicture;

  SportField({
    required this.id,
    required this.name,
    required this.opTime,
    required this.fieldType,
    required this.price,
    required this.fieldPicture,
  });

  factory SportField.fromJson(Map<String, dynamic> json) {
    return SportField(
      id: json["id"], 
      name: json["name"],
      opTime: json["opTime"], 
      fieldType: json["fieldType"], 
      price: json["price"],
      fieldPicture: json["fieldPicture"],
    );
  }

  factory SportField.fromDocument(DocumentSnapshot doc) {
    return SportField(
      id: doc.get("id"),
      name: doc.get("name"),
      opTime: doc.get("opTime"), 
      fieldType: doc.get("fieldType"), 
      price: doc.get("price"),
      fieldPicture: doc.get("fieldPicture"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "opTime": opTime,
      "fieldType": fieldType,
      "price": price,
      "fieldPicture": fieldPicture,
    };
  }
}