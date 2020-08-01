import 'package:flutter/material.dart';
import '../hex/hexColor.dart';
import '../services/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInEmailScreen extends StatefulWidget {
  const LogInEmailScreen({Key key}) : super(key: key);

  @override
  _LogInEmailScreenState createState() => _LogInEmailScreenState();
}

class _LogInEmailScreenState extends State<LogInEmailScreen> {
  FocusNode _passFocusNode;
  FocusNode _emailFocusNode;

  @override
  void dispose() {
    super.dispose();
    this._passFocusNode.dispose();
    this._emailFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _emailFocusNode.addListener(_onFocusNodeEvent);
    _passFocusNode = new FocusNode();
    _passFocusNode.addListener(_onFocusNodeEvent);
  }

  _onFocusNodeEvent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      borderSide: BorderSide.none,
    );
    final Color topGreen = HexColor.fromHex('#4BDF33');
    final Color midGreen = HexColor.fromHex('#33DF6F');
    final Color bottomGreen = HexColor.fromHex('#47B06B');

    Color _emailShadowColor() {
      return _emailFocusNode.hasFocus
          ? HexColor.fromHex('#CDCDCD')
          : Colors.transparent;
    }

    double _emailElevation() {
      return _emailFocusNode.hasFocus ? 15.0 : 0;
    }

    Color _passShadowColor() {
      return _passFocusNode.hasFocus
          ? HexColor.fromHex('#CDCDCD')
          : Colors.transparent;
    }

    double _passElevation() {
      return _passFocusNode.hasFocus ? 15.0 : 0;
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
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
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  "Login",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: HexColor.fromHex("FBFBFB"),
                    fontSize: 52,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: _emailElevation(),
                  shadowColor: _emailShadowColor(),
                  child: TextFormField(
                    focusNode: _emailFocusNode,
                    decoration: new InputDecoration(
                      hintText: "Email",
                      hintStyle: GoogleFonts.nunito(
                        color: HexColor.fromHex('#9D9D9D'),
                      ),
                      fillColor: HexColor.fromHex("FBFBFB"),
                      filled: true,
                      border: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                    onChanged: (val) {},
                  ),
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: _passElevation(),
                shadowColor: _passShadowColor(),
                child: TextFormField(
                  focusNode: _passFocusNode,
                  decoration: new InputDecoration(
                    hintText: "Password",
                    hintStyle: GoogleFonts.nunito(
                      color: HexColor.fromHex('#9D9D9D'),
                    ),
                    fillColor: HexColor.fromHex("FBFBFB"),
                    filled: true,
                    border: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                  onChanged: (val) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w300,
                        color: HexColor.fromHex("#FBFBFB"),
                        fontSize: 14,
                      ),
                    ),
                    FlatButton(
                      onPressed: null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#FBFBFB"),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Register",
                            style: GoogleFonts.nunito(
                              color: HexColor.fromHex("#14B54C"),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
