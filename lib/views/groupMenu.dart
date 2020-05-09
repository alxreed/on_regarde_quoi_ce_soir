import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/userService.dart';
import 'package:onregardequoicesoir/widgets/appBarOptions.dart';
import 'package:onregardequoicesoir/widgets/loader.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

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
          User user = User.fromDocumentSnapshot(documentUser);
          if (documentUser != null) {
            user.generateGroups(documentUser.data["groups"]);
          }
          if (!snapshot.hasData) return Loader();
          return SafeArea(
              child: Scaffold(
                  backgroundColor: colorController.background,
                  body: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: AppBarOptions(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Center(
                            child: TitleText('mes groupes'.toUpperCase(),
                                fontSize: 25),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[],
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          child: FittedBox(
                              child: FloatingActionButton(
                                backgroundColor: Constants.red,
                                onPressed: null,
                                child: Icon(
                                  Icons.add,
                                  color: Constants.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                  )));
        });
  }
}
