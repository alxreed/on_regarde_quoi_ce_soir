import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/userService.dart';
import 'package:onregardequoicesoir/widgets/loader.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class GroupMenu extends StatefulWidget {
  final FirebaseUser user;

  GroupMenu({Key key, this.user}) : super(key: key);

  _GroupMenuState createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userService.getUser(widget.user.uid),
        builder: (context, snapshot) {
          DocumentSnapshot documentUser = snapshot.data;
          User.fromDocumentSnapshot(documentUser);
          if (!snapshot.hasData) return Loader();
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
                            child: TitleText('mes groupes'.toUpperCase(),
                                fontSize: 25),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[],
                          ),
                        ),
                      ],
                    ),
                  ))));
        });
  }
}
