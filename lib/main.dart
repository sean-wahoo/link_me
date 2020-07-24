import 'package:flutter/material.dart';
import 'hex/hexColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LinkMe",
      theme: ThemeData(
        primaryColor: (HexColor.fromHex('#000000')),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Wowee app"),
        ),
        body: Center(
          child: Text("yay"),
        ),
      ),
    );
  }
}
