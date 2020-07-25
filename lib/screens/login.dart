import 'package:flutter/material.dart';
import '../hex/hexColor.dart';
import '../services/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color topGreen = HexColor.fromHex('#4BDF33');
    final Color midGreen = HexColor.fromHex('#33DF6F');
    final Color bottomGreen = HexColor.fromHex('#47B06B');
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LogoImage(
              height: 100,
              width: 100,
            ),
            Text(
              "Login or Register below!",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            GSignInButton(
              text: "LOGIN WITH GOOGLE",
              icon: FontAwesomeIcons.google,
              color: Colors.white10,
              loginMethod: auth.googleSignIn,
            ),
          ],
        ),
      ),
    );
  }
}

class GSignInButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const GSignInButton({this.color, this.icon, this.text, this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        label: Text(text),
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/linkme.png',
        height: height,
        width: width,
      ),
    );
  }
}
