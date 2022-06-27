import 'package:project_ambw/class/CUser.dart';

class UserSession {
  static UserCls session = UserCls(email: '', nama: '', alamat: '', noTelp: '', isAdmin: false);

  static void updateSession({required UserCls newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = UserCls(email: '', nama: '', alamat: '', noTelp: '', isAdmin: false);
  }
}

class AdminSession {
  static Admin session = Admin(email: '', nama: '', alamat: '', noTelp: '', isAdmin: true);

  static void updateSession({required Admin newSession}) {
    session = newSession;
  }

  static void resetSession() {
    session = Admin(email: '', nama: '', alamat: '', noTelp: '', isAdmin: true);
  }
}