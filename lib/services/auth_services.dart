import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> authWithGoogle();
  Future<bool> authWithFacebook();
  User? currentUser();
  Future<void> logout();
}

class AuthSrevicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> authWithGoogle() async {
    final gUser = await GoogleSignIn().signIn();
    final gAuth = await gUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> authWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    if (loginResult.status != LoginStatus.success) {
      return false;
    }
    final credential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }
}
