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
            children: <Widget>[
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: _emailElevation(),
                shadowColor: _emailShadowColor(),
                child: TextFormField(
                  focusNode: _emailFocusNode,
                  decoration: new InputDecoration(
                    hintText: "Email",
                    fillColor: HexColor.fromHex("FBFBFB"),
                    filled: true,
                    border: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                  onChanged: (val) {},
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
                    fillColor: HexColor.fromHex("FBFBFB"),
                    filled: true,
                    border: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                  onChanged: (val) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
