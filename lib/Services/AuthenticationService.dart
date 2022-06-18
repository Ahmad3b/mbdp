import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mbdp/UserTypes.dart';

class AuthenticationService {
  final FirebaseAuth _fireauth;
  UserCredential? credential;
  String SchoolId = "";
  AuthenticationService(this._fireauth);

  Stream<User?> get authStateChanages => _fireauth.authStateChanges();

  void setSchoolId(String schoolId) {
    SchoolId = schoolId;
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    print("Sing In Executing " + email + " & " + password);
    try {
      credential = await _fireauth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Auth Sucesseded ");

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      print("Error " + e.message!);
      return e.message;
    }
  }

  Future<UserCredential?> registerUser({
    required String email,
    String? password,
    required UserTypes userType,
    required String FullName,
  }) async {
    try {
      var newcredential = await _fireauth.createUserWithEmailAndPassword(
          email: email, password: password!);
      return newcredential;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}
