import 'package:flutter/material.dart';
import 'hex/hexColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final Color topGreen = HexColor.fromHex('#4BDF33');
    final Color midGreen = HexColor.fromHex('#33DF6F');
    final Color bottomGreen = HexColor.fromHex('#47B06B');
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    topGreen,
                    midGreen,
                    bottomGreen,
                  ],
                  stops: [
                    0.1,
                    0.4,
                    0.9,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
