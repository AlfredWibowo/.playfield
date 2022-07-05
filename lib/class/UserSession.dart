import 'package:project_ambw/class/User.dart';

class ConsumerSession {
  static Consumer session = Consumer(
    balance: 0,
    notifId: [],
    orderId: [],
    email: "",
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
      notifId: [],
      orderId: [],
      email: "",
      name: "",
      address: "",
      phoneNumber: "",
      profilePicture: "",
    );
  }
}

class AdminSession {
  static Admin session = Admin(
    notifId: [],
    orderId: [],
    sportCentreId: [],
    email: "",
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
      notifId: [],
      orderId: [],
      sportCentreId: [],
      email: "",
      name: "",
      address: "",
      phoneNumber: "",
      profilePicture: "",
    );
  }
}
