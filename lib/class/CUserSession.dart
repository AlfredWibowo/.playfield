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