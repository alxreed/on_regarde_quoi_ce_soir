import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

import 'loader.dart';

class ListMenuTile extends StatefulWidget {
  final String groupUID;

  ListMenuTile({Key key, this.groupUID}) : super(key: key);

  _ListMenuTileState createState() => _ListMenuTileState();
}

class _ListMenuTileState extends State<ListMenuTile> {
  FirebaseUser user;

  @override
  initState() {
    super.initState();
    _initiateUser();
  }

  Future _initiateUser() async {
    user = await authService.userLogged;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groupService.getStreamGroup(widget.groupUID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container(width: 0.0, height: 0.0);
        DocumentSnapshot documentSnapshot = snapshot.data;
        Group group = Group.fromSnapshot(documentSnapshot);
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 35),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Constants.white))),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      group.name.toUpperCase(),
                      fontSize: 20,
                    ),
                    Row(
                      children: <Widget>[
                        ...new List.generate(group.members.length, (index) {
                          return displaySurname(group, index);
                        }),
                        if (group.members.length >= 5)
                          Text(
                            "...",
                            style: TextStyle(color: Constants.grey),
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Text displaySurname(Group group, int index) {
    if (group.members[index].uid != user.uid && index <= 5) {
      return Text(
        "${group.members[index].surname}, ",
        style: TextStyle(color: Constants.grey),
      );
    } else {
      return Text("");
    }
  }
}
