import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('hello'),
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      child: FlatButton(
        child: Text('log out'),
        color: Colors.red,
        onPressed: () async {
          await auth.signOut();
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}
