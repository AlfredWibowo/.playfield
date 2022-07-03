import 'package:cloud_firestore/cloud_firestore.dart';

class SportCentre {
  String id;
  String name;
  String address;
  String city;
  String phoneNumber;
  List<String> sportFieldId;

  SportCentre({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.sportFieldId,
  });

  factory SportCentre.fromJson(Map<String, dynamic> json) {
    return SportCentre(
      id: json["id"], 
      name: json["name"], 
      address: json["address"], 
      city: json["city"],
      phoneNumber: json["phoneNumber"],
      sportFieldId: List<String>.from(json["sportFieldId"].map((x) => x)),
    );
  }

  factory SportCentre.fromDocument(DocumentSnapshot doc) {
    return SportCentre(
      id: doc.get("id"), 
      name: doc.get("name"), 
      address: doc.get("address"), 
      city: doc.get("city"),
      phoneNumber: doc.get("phoneNumber"),
      sportFieldId: List<String>.from(doc.get("sportFieldId")),
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "city": city,
      "phoneNumber": phoneNumber,
      "sportFieldId": List<String>.from(sportFieldId),
    };
  }
}