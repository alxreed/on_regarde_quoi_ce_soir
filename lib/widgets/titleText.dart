import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';

class TitleText extends Text {
  final String data;
  final double fontSize;

  TitleText(this.data, {@required this.fontSize})
      : assert(data != null),
        assert(fontSize != null),
        super(data,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
              color: colorController.text,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            )));
}

/*
Text(
'on regarde quoi ce soir ?'.toUpperCase(),
textAlign: TextAlign.center,
style: GoogleFonts.montserrat(
textStyle: TextStyle(
color: colorController.text,
fontWeight: FontWeight.bold,
fontSize: 38,
)),
),*/
