import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../hex/hexColor.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            children: <Widget>[
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 50,
              ),
              Center(
                child: Text(
                  'Loading...',
                  style: GoogleFonts.nunito(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex('#FBFBFB'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
