import 'package:flutter/material.dart';
import '../hex/hexColor.dart';
import '../services/export.dart';
import '../shared/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class LogInEmailScreen extends StatefulWidget {
  const LogInEmailScreen({Key key}) : super(key: key);

  @override
  _LogInEmailScreenState createState() => _LogInEmailScreenState();
}

class _LogInEmailScreenState extends State<LogInEmailScreen> {
  FocusNode _passFocusNode;
  FocusNode _emailFocusNode;

  String email;
  String password;
  String error = '';
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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

  setError(str) {
    setState(() {
      error = str;
    });
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

    isLoading() {
      return loading ? Loading() : Text('');
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
                child: Center(
                  child: Image.asset(
                    'assets/linkme.png',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: _emailElevation(),
                        shadowColor: _emailShadowColor(),
                        child: TextFormField(
                          validator: (val) => EmailValidator.validate(val)
                              ? null
                              : 'Please enter a valid email',
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
                          onChanged: (val) {
                            setState(() => email = val);
                          },
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
                        obscureText: true,
                        validator: (val) {
                          Pattern passPattern =
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          RegExp regex = new RegExp(passPattern);
                          if (!regex.hasMatch(val)) {
                            return 'Password must have at least 6 characters, one letter, and one number';
                          } else {
                            return null;
                          }
                        },
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
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: FlatButton(
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor.fromHex('#FBFBFB'),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Login",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#14B54C"),
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInEmail(email, password);

                            if (result == null) {
                              setError(
                                  'Could not sign in with those credentials!');
                              setState(() => loading = false);
                            }

                            if (result == "ERROR_WRONG_PASSWORD") {
                              setError('Incorrect password!');
                              setState(() => loading = false);
                            }
                            _auth.getUser.then(
                              (user) {
                                if (user != null) {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              isLoading(),
              Center(
                child: Opacity(
                  opacity: error.length == 0 ? 0.0 : 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor.fromHex('#CA0E3C'),
                        ),
                        borderRadius: BorderRadius.circular(18),
                        color: HexColor.fromHex('#FADCE3'),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          error,
                          style: GoogleFonts.nunito(
                            color: HexColor.fromHex('#CA0E3C'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?  ",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w300,
                        color: HexColor.fromHex("#FBFBFB"),
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacementNamed(context, '/signUpEmail')
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.nunito(
                          color: HexColor.fromHex("#FBFBFB"),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
