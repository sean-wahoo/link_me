import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/export.dart';
import 'services/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().fbUser)
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/logInEmail': (context) => LogInEmailScreen(),
          '/signUpEmail': (context) => SignUpEmailScreen(),
        },
      ),
    );
  }
}
