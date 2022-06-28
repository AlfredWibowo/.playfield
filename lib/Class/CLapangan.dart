
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final List<String> fieldType = ["Badminton", "Futsal", "Basketball"];

class Field{
  String? fieldID;
  String? type;
  int? priceHour;
  List<FieldOccupancy> occupancies = [];

  Field({required String this.fieldID, required String this.type, required int this.priceHour});

  Field.jsonConstructor(String FID, String type, int price, List<FieldOccupancy> occupancies) {
    fieldID = FID;
    this.type = type;
    priceHour = price;
    this.occupancies = occupancies;
  }

  bool checkOccupancies(int hour) {
    // If on hour isOccupied 
    // then return true
    // else false
    return true;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "fieldID": fieldID,
      "type": type,
      "priceHour": priceHour,
      "occupancies": List<dynamic>.from(occupancies.map((x) => x.toJson()))
    };
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field.jsonConstructor(
      json['fieldID'],
      json['type'],
      json['priceHour'],
      json["occupancies"] == null ? [] : List<FieldOccupancy>.from(json["occupancies"].map((x) => FieldOccupancy.fromJson(x)))
    );
  }

  factory Field.fromDocument(DocumentSnapshot doc) {
    List<dynamic> fieldOcc = doc.get('fieldOccupancy');
    List<FieldOccupancy> castedOCC = fieldOcc.map((e) => FieldOccupancy(hour: e['hour'], isOccupied: e['isOccupied'])).toList();
    return Field.jsonConstructor(
      doc.get('fieldID'),
      doc.get('type'),
      doc.get('priceHour'),
      castedOCC,
    );
  }
}

class FieldOccupancy {
  int status; // 0 - active, 1- used, 2 - canceled
  late String ticketID; // PRIMARY
  String hour;
  bool isOccupied;

  FieldOccupancy({required this.hour,required this.isOccupied, this.status = 0}){
    var uuid = const Uuid();
    ticketID = uuid.v4();
  }

  FieldOccupancy.jsonConstructor({required this.hour,required this.isOccupied, required this.status, required this.ticketID});

  void use() {
    status = 1; // used
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "ticketID": ticketID,
      "hour": hour,
      "isOccupied": isOccupied
    };
  }

  factory FieldOccupancy.fromDocument(DocumentSnapshot doc) {
    return FieldOccupancy.jsonConstructor(
      ticketID:doc.get('ticketID'),
      status: doc.get('status'),
      hour: doc.get('hour'),
      isOccupied: doc.get('isOccupied')
    );
  }

  factory FieldOccupancy.fromJson(Map<String, dynamic> json) {
    return FieldOccupancy.jsonConstructor(
      ticketID:json['ticketID'],
      status: json['status'],
      hour: json['hour'],
      isOccupied: json['isOccupied']
    );
  }


}