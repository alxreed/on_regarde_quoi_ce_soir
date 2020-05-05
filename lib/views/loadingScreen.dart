import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorController.background,
        body: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Text(
              'on regarde quoi ce soir ?'.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                color: colorController.text,
                fontWeight: FontWeight.bold,
                fontSize: 38,
              )),
            ),
          ),
        ));
  }
}
