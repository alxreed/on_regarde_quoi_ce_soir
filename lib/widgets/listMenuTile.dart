import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/views/groupRoutingPage.dart';
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
  bool selected;

  @override
  initState() {
    super.initState();
    selected = false;
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
          onLongPress: _selectGroup,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupRoutingPage(group: group),
                    ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 35),
            decoration: BoxDecoration(
              color: selected ? Constants.red : colorController.background,
                border: Border(
                    bottom:
                        BorderSide(color: colorController.text, width: 0.3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            style: TextStyle(color: selected ? Constants.lightGrey : Constants.grey),
                          )
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _showDialog(group);
                  },
                  child: Icon(
                    Icons.delete,
                    color: selected ? colorController.text : colorController.background,
                  ),
                )
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
        "${StringUtils.capitalize(group.members[index].surname)}, ",
        style: TextStyle(color: selected ? Constants.lightGrey : Constants.grey),
      );
    } else {
      return Text("");
    }
  }

  void _selectGroup() {
    setState(() {
      selected = !selected;
    });
  }

  void _deleteOrRemoveGroup(Group group) {
    if (group.members.length == 1) {
      groupController.deleteGroup(group.uid);
    } else {
      userController.removeGroupFromUser(user.uid, group.uid);
      groupController.removeUserFromGroup(group.uid, user.uid);
    }
  }

  void _showDialog(Group group) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
            group.members.length == 1 ? Text('Es-tu sûr de vouloir effacer ce groupe ?') : Text('Es-tu de vouloir sortir de ce groupe ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NON'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OUI'),
                onPressed: () {
                  _deleteOrRemoveGroup(group);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
