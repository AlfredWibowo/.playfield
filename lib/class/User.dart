import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  String address;
  String phoneNumber;
  String profilePicture;
  List<String> orderId;
  List<String> notifId;

  User(
      {required this.email,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.profilePicture,
      required this.orderId,
      required this.notifId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      name: json["name"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
      orderId: List<String>.from(json["orderId"].map((x) => x)),
      notifId: List<String>.from(json["orderId"].map((x) => x)),
    );
  }
}

class Consumer extends User {
  int balance;

  Consumer(
      {required this.balance,
      required String email,
      required String name,
      required String address,
      required String phoneNumber,
      required String profilePicture,
      required List<String> orderId,
      required List<String> notifId})
      : super(
            email: email,
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            profilePicture: profilePicture,
            orderId: orderId,
            notifId: notifId);

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(
      balance: json["balance"],
      email: json["email"],
      name: json["name"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
      orderId: List<String>.from(json["orderId"].map((x) => x)),
      notifId: List<String>.from(json["notifId"].map((x) => x)),
    );
  }

  factory Consumer.fromDocument(DocumentSnapshot doc) {
    return Consumer(
      balance: doc.get("balance"),
      email: doc.get("email"),
      name: doc.get("name"),
      address: doc.get("address"),
      phoneNumber: doc.get("phoneNumber"),
      profilePicture: doc.get("profilePicture"),
      orderId: List<String>.from(doc.get("orderId")),
      notifId: List<String>.from(doc.get("notifId")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "email": email,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
      "orderId": List<String>.from(orderId),
      "notifId": List<String>.from(notifId),
    };
  }
}

class Admin extends User {
  List<String> sportCentreId;

  Admin(
      {required this.sportCentreId,
      required String email,
      required String name,
      required String address,
      required String phoneNumber,
      required String profilePicture,
      required List<String> orderId,
      required List<String> notifId})
      : super(
            email: email,
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            profilePicture: profilePicture,
            orderId: orderId,
            notifId: notifId);

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      sportCentreId: List<String>.from(json["sportCentreId"].map((x) => x)),
      email: json["email"],
      name: json["name"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
      orderId: List<String>.from(json["orderId"].map((x) => x)),
      notifId: List<String>.from(json["notifId"].map((x) => x)),
    );
  }

  factory Admin.fromDocument(DocumentSnapshot doc) {
    return Admin(
      sportCentreId: List<String>.from(doc.get("sportCentreId")),
      email: doc.get("email"),
      name: doc.get("name"),
      address: doc.get("address"),
      phoneNumber: doc.get("phoneNumber"),
      profilePicture: doc.get("profilePicture"),
      orderId: List<String>.from(doc.get("orderId")),
      notifId: List<String>.from(doc.get("notifId")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sportCentreId": List<String>.from(sportCentreId),
      "email": email,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
      "orderId": List<String>.from(orderId),
      "notifId": List<String>.from(notifId),
    };
  }
}
