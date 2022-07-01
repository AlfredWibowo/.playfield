import 'package:aplikasi_booking_lapangan_online/class/User.dart';

class ConsumerSession {
  static Consumer session = Consumer(
    balance: 0,
    orderId: [],
    email: "",
    password: "",
    name: "",
    address: "",
    phoneNumber: "",
    profilePicture: "",
  );

  static void updateSession({required Consumer newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = Consumer(
      balance: 0,
      orderId: [],
      email: "",
      password: "",
      name: "",
      address: "",
      phoneNumber: "",
      profilePicture: "",
    );
  }
}

class AdminSession {
  static Admin session = Admin(
    orderId: [],
    sportCentreId: [],
    email: "",
    password: "",
    name: "",
    address: "",
    phoneNumber: "",
    profilePicture: "",
  );

  static void updateSession({required Admin newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = Admin(
    orderId: [],
    sportCentreId: [],
    email: "",
    password: "",
    name: "",
    address: "",
    phoneNumber: "",
    profilePicture: "",
  );
  }
}
