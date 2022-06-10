import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {

  static Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }

  static String getEmail() {
    return auth.currentUser!.email.toString();
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
      message = 'Successfull';
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
      message = 'Successfull';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      message = '${e.code}';
    }
    return message;
  }
}
