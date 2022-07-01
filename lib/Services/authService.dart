import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static FirebaseAuth auth = FirebaseAuth.instance;
  
  //change password

  static String getEmailUser() {
    return auth.currentUser!.email.toString();
  }

  static Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }


  static Future<String> login({required String email, required String password}) async {
    String message;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print('Succesful');
      message = 'Successful';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      message = '${e}';
      }
    return message;
  }

  static Future<String> signUp({required String email, required String password}) async {
    String message;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      message = 'Successful';
    } on FirebaseAuthException catch (e) {
      message = '${e.code}';
    }
    return message;
  }

  static Future<void> logout() async {
    await auth.signOut();
  }

  static Future<String> forgotPassword({required String email}) async {
    String message;
    try {
      await auth.sendPasswordResetEmail(email: email);
      message = 'Successful';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      message = '${e.code}';
    }
    return message;
  }

    static Future<String> changePassword({required String newPassword}) async {
    String message;

    try {
      await auth.currentUser!.updatePassword(newPassword);
      message = 'Successful';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      message = '${e.code}';
    }
    return message;
  }
}
