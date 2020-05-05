import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: colorController.background,
        body: Center(
          child: Text(
            "caca",
            style: TextStyle(color: colorController.text),
          ),
        ));
  }
}
