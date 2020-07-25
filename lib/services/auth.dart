import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  // sign in with google
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
      FirebaseUser user = result.user;

      updateUserdata(user);
    } catch (error) {
      print(error);
      return null;
    }

    Future<void> updateUserData(FirebaseUser user) {
      DocumentReference reportRef =
          _db.collection('reports').document(user.uid);

      return reportRef.setData({
        'uid': user.uid,
        'lastActivity': DateTime.now(),
      }, merge: true);
    }

    Future<void> signOut() {
      return _auth.signOut();
    }
  }

  // sign out with google

  // register with email/pass

  // sign in with email/pass

  // sign out with email/pass

}
