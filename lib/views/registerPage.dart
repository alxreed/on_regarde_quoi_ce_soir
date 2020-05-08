import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/views/groupMenu.dart';
import 'package:onregardequoicesoir/widgets/loginForm.dart';
import 'package:onregardequoicesoir/widgets/registerForm.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if(snapshot.hasData) return GroupMenu();
        return SafeArea(
            child: Scaffold(
                backgroundColor: colorController.background,
                body: SingleChildScrollView(
                    child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Center(
                          child: TitleText("s'inscrire".toUpperCase(),
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Container(
                          child: RegisterForm(),
                        ),
                      ),
                    ],
                  ),
                ))));
      },
    );
  }
}
