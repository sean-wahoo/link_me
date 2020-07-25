import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/export.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
