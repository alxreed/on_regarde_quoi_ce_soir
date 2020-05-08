import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/views/registerPage.dart';
import 'package:onregardequoicesoir/widgets/loginForm.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

import 'groupMenu.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            child: TitleText('se connecter'.toUpperCase(),
                                fontSize: 25),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: LoginForm(),
                              ),
                              Container(
                                child: Center(
                                  child: FloatingActionButton.extended(
                                    heroTag: "google",
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      authService
                                          .googleSignIn()
                                          .catchError((e) => _loginFailed());
                                    },
                                    icon: Icon(
                                      FontAwesome.google,
                                      color: colorController.background,
                                    ),
                                    label: Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: colorController.background),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: FloatingActionButton.extended(
                                    heroTag: "facebook",
                                    backgroundColor: Color(0xFF4267B2),
                                    onPressed: () {
                                      // TODO : FACEBOOK SIGN IN
                                    },
                                    icon: Icon(
                                      FontAwesome.facebook,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Sign in with facebook',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: FlatButton(
                                  child: Text(
                                    "s'incrire",
                                    style:
                                        TextStyle(color: colorController.text),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                ),
                              ),
                              Container(
                                child: FlatButton(
                                  child: Text(
                                    "deco",
                                    style:
                                    TextStyle(color: colorController.text),
                                  ),
                                  onPressed: (() => authService.signOut())
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))));
        });
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
