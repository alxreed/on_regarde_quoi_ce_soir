import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/views/routingLoginRegister.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

import 'loginPage.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer _timer;

  _LoadingPageState() {
    _timer = new Timer(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RoutingLoginRegister()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorController.background,
        body: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: TitleText('on regarde quoi ce soir ?'.toUpperCase(), fontSize: 38),
          ),
        ));
  }
}
