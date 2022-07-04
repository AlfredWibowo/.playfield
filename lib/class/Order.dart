import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/class/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  String date;
  String time;
  num amount;
  int status;
  //0: waitting: waitting acc from admin
  //1: Active: after acc by admin
  //2: Rejected: rejected by admin
  //3: Used: after User scan qr code

  Consumer consumer;
  SportCentre sportCentre;
  SportField sportField;

  Order({
    required this.id,
    required this.date,
    required this.time,
    required this.amount,
    required this.status,
    required this.consumer,
    required this.sportCentre,
    required this.sportField,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      date: json["date"],
      time: json["time"],
      amount: json["amount"],
      status: json["status"],
      consumer: Consumer.fromJson(json["consumer"]),
      sportCentre: SportCentre.fromJson(json["sportCentre"]),
      sportField: SportField.fromJson(json["sportField"]),
    );
  }

  factory Order.fromDocument(DocumentSnapshot doc) {
    final consumer = Map<String, dynamic>.from(doc.get("consumer"));
    final sc = Map<String, dynamic>.from(doc.get("sportCentre"));
    final sf = Map<String, dynamic>.from(doc.get("sportField"));
    return Order(
      id: doc.get("id"),
      date: doc.get("date"),
      time: doc.get("time"),
      amount: doc.get("amount"),
      status: doc.get("status"),
      consumer: Consumer.fromJson(consumer),
      sportCentre: SportCentre.fromJson(sc),
      sportField: SportField.fromJson(sf),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "time": time,
      "amount": amount,
      "status": status,
      "consumer": consumer.toJson(),
      "sportCentre": sportCentre.toJson(),
      "sportField": sportField.toJson(),
    };
  }
}
