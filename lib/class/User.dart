import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String password;
  String name;
  String address;
  String phoneNumber;
  String profilePicture;

  User(
      {required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
      name: json["name"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
    );
  }
}

class Consumer extends User {
  double balance;
  List<String> orderId;

  Consumer({
    required this.balance,
    required this.orderId,
    required String email,
    required String password,
    required String name,
    required String address,
    required String phoneNumber,
    required String profilePicture,
  }) : super(
          email: email,
          password: password,
          name: name,
          address: address,
          phoneNumber: phoneNumber,
          profilePicture: profilePicture,
        );

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(
      balance: json["balance"],
      orderId: List<String>.from(json["orderId"].map((x) => x)),
      email: json["email"],
      password: json["password"],
      name: json["name"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      profilePicture: json["profilePicture"],
    );
  }

  factory Consumer.fromDocument(DocumentSnapshot doc) {
    return Consumer(
      balance: doc.get("balance"),
      orderId: List<String>.from(doc.get("orderId")),
      email: doc.get("email"),
      password: doc.get("password"),
      name: doc.get("name"),
      address: doc.get("address"),
      phoneNumber: doc.get("phoneNumber"),
      profilePicture: doc.get("profilePicture"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "orderId": List<String>.from(orderId),
      "email": email,
      "password": password,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
    };
  }
}

class Admin extends User {
  List<String> sportCentreId;
  List<String> orderId;

  Admin({
    required this.orderId,
    required this.sportCentreId,
    required String email,
    required String password,
    required String name,
    required String address,
    required String phoneNumber,
    required String profilePicture,
  }) : super(
          email: email,
          password: password,
          name: name,
          address: address,
          phoneNumber: phoneNumber,
          profilePicture: profilePicture,
        );

  factory Admin.fromJson(Map<String, dynamic> json) {
      return Admin(
        sportCentreId: List<String>.from(json["sportCentreId"].map((x) => x)),
        orderId: List<String>.from(json["orderId"].map((x) => x)),
        email: json["email"],
        password: json["password"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
      );
    }

  factory Admin.fromDocument(DocumentSnapshot doc) {
    return Admin(
      sportCentreId: List<String>.from(doc.get("sportCentreId")),
      orderId: List<String>.from(doc.get("orderId")),
      email: doc.get("email"),
      password: doc.get("password"),
      name: doc.get("name"),
      address: doc.get("address"),
      phoneNumber: doc.get("phoneNumber"),
      profilePicture: doc.get("profilePicture"),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "sportCentreId": List<String>.from(sportCentreId),
      "orderId": List<String>.from(orderId),
      "email": email,
      "password": password,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
    };
  }
}
