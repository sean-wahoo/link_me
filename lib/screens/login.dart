import 'package:flutter/material.dart';
import '../hex/hexColor.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color topGreen = HexColor.fromHex('#4BDF33');
    final Color midGreen = HexColor.fromHex('#33DF6F');
    final Color bottomGreen = HexColor.fromHex('#47B06B');
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBackground(
            top: topGreen,
            mid: midGreen,
            bottom: bottomGreen,
          ),
          LogoImage(),
        ],
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key key,
    @required this.top,
    @required this.mid,
    @required this.bottom,
  }) : super(key: key);

  final Color top;
  final Color mid;
  final Color bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            top,
            mid,
            bottom,
          ],
          stops: [
            0.1,
            0.4,
            0.9,
          ],
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/linkme.png',
        height: 200,
        width: 200,
      ),
    );
  }
}
