import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/loginData.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginData loginData = LoginData();

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(
      height: 24,
    );
    Color cursorColor = colorController.text;

    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "Tape ton adresse email",
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Email",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                loginData.email = value;
              },
            ),
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: "Tape ton mot de passe",
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Mot de passe",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              onSaved: (value) {
                loginData.password = value;
              },
            ),
            sizedBoxSpace,
            RaisedButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                authService.signIn(loginData).catchError((e) => _loginFailed());
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Constants.red),
                child: Text(
                  "connexion".toUpperCase(),
                  style: TextStyle(color: Constants.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _loginFailed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Sign in failed"),
            actions: <Widget>[
              FlatButton(
                child: Text('GOT IT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
