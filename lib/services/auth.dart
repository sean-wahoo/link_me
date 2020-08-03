import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/export.dart';
import 'dart:async';

class AuthService {
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get emailUser {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get fbUser => _auth.onAuthStateChanged;

  // sign in with google

  Future<void> updateUserData(FirebaseUser fbUser) {
    DocumentReference reportRef =
        _db.collection('reports').document(fbUser.uid);

    return reportRef.setData({
      'uid': fbUser.uid,
      'lastActivity': DateTime.now(),
    }, merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser fbUser = result.user;

      updateUserData(fbUser);
      return fbUser;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // sign out with google

  // register with email/pass

  Future signUpEmail(
      String email, String password, String confirmPassword) async {
    try {
      if (password == confirmPassword) {
        AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseUser emailUser = result.user;
        return _userFromFirebaseUser(emailUser);
      }
    } catch (error) {
      print(error.toString());
      if (error is PlatformException) {
        if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return "ERROR_EMAIL_ALREADY_IN_USE";
        }
      }
      return null;
    }
  }

  // sign in with email/pass

  // sign out with email/pass

}
