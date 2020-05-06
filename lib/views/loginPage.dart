import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorController.background,
        body: Container(
          child: Column(
            children: <Widget>[
              Container(child: TitleText('on regarde quoi ce soir ?'.toUpperCase(), fontSize: 38),),
            ],
          ),
        ));
  }
}
