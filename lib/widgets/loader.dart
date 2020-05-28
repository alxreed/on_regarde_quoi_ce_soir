import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.background,
      body: Center(
        child: SpinKitFadingCircle(
          color: colorController.text,
        ),
      ),
    );
  }
}
