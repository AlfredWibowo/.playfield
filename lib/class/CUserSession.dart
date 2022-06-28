import 'package:project_ambw/class/CUser.dart';

class ConsumerSession {
  static Consumer session = Consumer(email: '', nama: '', alamat: '', noTelp: '', isAdmin: false, profilePicture: "");

  static void updateSession({required Consumer newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = Consumer(email: '', nama: '', alamat: '', noTelp: '', isAdmin: false, profilePicture: "");
  }
}

class AdminSession {
  static Admin session = Admin(email: '', nama: '', alamat: '', noTelp: '', isAdmin: true, profilePicture: "");

  static void updateSession({required Admin newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = Admin(email: '', nama: '', alamat: '', noTelp: '', isAdmin: true, profilePicture: "");
  }
}