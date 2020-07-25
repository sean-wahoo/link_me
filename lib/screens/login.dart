import 'package:flutter/material.dart';
import '../hex/hexColor.dart';
import '../services/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoImage(
              height: 150,
              width: 150,
            ),
            Text(
              "Login or Register below!",
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            GSignInButton(
              text: "Sign in with Google",
              icon: FontAwesomeIcons.google,
              color: Colors.white,
              loginMethod: auth.googleSignIn,
            ),
            FlatButton.icon(
              onPressed: () => {Navigator.pushNamed(context, '/logInEmail')},
              label: Text(
                "Sign in with Email",
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              icon: Icon(FontAwesomeIcons.envelope, color: Colors.white),
              color: Colors.black54,
            )
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
      margin: EdgeInsets.only(top: 100, bottom: 50),
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        label: Text(text),
        padding: EdgeInsets.all(40),
        icon: Icon(icon, color: HexColor.fromHex('#33DF6F')),
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
