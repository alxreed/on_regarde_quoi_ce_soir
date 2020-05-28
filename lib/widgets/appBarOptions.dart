import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/views/addNewGroupMember.dart';

class AppBarOptions extends StatefulWidget {
  final bool canAddFriends;

  AppBarOptions({Key key, this.canAddFriends}) : super(key: key);

  _AppBarOptionsState createState() => _AppBarOptionsState();
}

class _AppBarOptionsState extends State<AppBarOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (widget.canAddFriends)
          Container(
            height: 50,
            width: 50,
            child: FittedBox(
                child: FlatButton(
              onPressed: () {
                // TODO FIND NEW FRIENDS FOR THE GROUP
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewGroupMember(group: groupService.group),
                    ));
              },
              child: Icon(
                MaterialCommunityIcons.account_plus,
                color: colorController.text,
                size: 60,
              ),
            )),
          ),
        Container(
          height: 50,
          width: 50,
          child: FittedBox(
              child: FlatButton(
            onPressed: () => authService.signOut(),
            child: Icon(
              MaterialCommunityIcons.power_standby,
              color: colorController.text,
              size: 60,
            ),
          )),
        ),
      ],
    );
  }
}
