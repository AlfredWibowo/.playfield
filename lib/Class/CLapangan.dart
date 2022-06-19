import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Field{
  String? _fieldID;
  String? _type;
  int? _priceHour;
  List<FieldOccupancy> _occupancies = [];

  Field(String FID, String type, int price) {
    _fieldID = FID;
    _type = type;
    _priceHour = price;
  }

  Field.jsonConstructor(String FID, String type, int price, List<FieldOccupancy> occupancies) {
    _fieldID = FID;
    _type = type;
    _priceHour = price;
    _occupancies = occupancies;
  }

  void insert(FieldOccupancy input) {
    _occupancies.add(input);
  }

  bool checkOccupancies(int hour) {
    // If on hour isOccupied 
    // then return true
    // else false
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      "fieldID": _fieldID,
      "type": _type,
      "priceHour": _priceHour,
      "fieldOccupancy": _occupancies
    };
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field.jsonConstructor(
      json['fieldID'],
      json['type'],
      json['priceHour'],
      json['fieldOccupancy']
    );
  }

  factory Field.fromDocument(DocumentSnapshot doc) {
    return Field.jsonConstructor(
      doc.get('fieldID'),
      doc.get('type'),
      doc.get('priceHour'),
      doc.get('fieldOccupancy'),
    );
  }
}

class FieldOccupancy {
  String? _gedungID;
  int? _status; // 0 - active, 1- used, 2 - canceled
  String? _ticketID; // PRIMARY
  int? _hour;
  bool? _isOccupied;

  FieldOccupancy(int hour, bool occupancy, String GID, {int status = 0}){
    var uuid = const Uuid();
    _ticketID = uuid.v4();

    _hour = hour;
    _isOccupied = isOccupied;
    _status = status;
    _gedungID = GID;
  }

  void use() {
    _status = 1; // used
  }

  get isOccupied {
    return _isOccupied;
  }    

  get hour {
    return _hour;
  }

  get id {
    return _ticketID;
  }
}