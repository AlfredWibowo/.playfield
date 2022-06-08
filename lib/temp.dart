import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  emailNotRegistered,
  invalidEmail,
  weakPassword,
  unknown
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "user-not-found":
        status = AuthStatus.emailNotRegistered;
        break;
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(e) {
    String errorMessage;
    switch (e) {
      case AuthStatus.invalidEmail:
        errorMessage = "Ivalid Email.";
        break;
      case AuthStatus.emailNotRegistered:
        errorMessage = "No user found for that email.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Wrong password provided for that user.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage = "The account already exists for that email.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}

FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {

  static Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }

  static Future<AuthStatus> login({required String email, required String password}) async {
    AuthStatus status;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }

    return status;
  }

  static Future<AuthStatus> signUp({required String email, required String password}) async {
    AuthStatus status;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }

  static Future<void> logout() async {
    await auth.signOut();
  }

  static Future<AuthStatus> forgotPassword({required String email}) async {
    AuthStatus status;
    
    try {
      await auth.sendPasswordResetEmail(email: email);
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }
}
