import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/widgets/loader.dart';

import 'groupHomePage.dart';
import 'groupMemberPage.dart';
import 'myProfilePage.dart';

class GroupRoutingPage extends StatefulWidget {
  final Group group;

  GroupRoutingPage({Key key, this.group}) : super(key: key);

  _GroupRoutingPageState createState() => _GroupRoutingPageState();
}

class _GroupRoutingPageState extends State<GroupRoutingPage> {
  FirebaseUser user;

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _initiateUser();
  }

  Future _initiateUser() async {
    user = await authService.userLogged;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groupService.getStreamGroup(widget.group.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loader();
        DocumentSnapshot documentSnapshot = snapshot.data;
        Group group = Group.fromSnapshot(documentSnapshot);
        GroupMember chosenMovieMember = _setChosenMovieMember(group);
        GroupMember meAsGroupMember = _findUserLogged(group);
        _removeUserLoggedFromGroup(group, meAsGroupMember);
        return PageView(
          controller: _controller,
          children: <Widget>[
            GroupHomePage(groupMember: chosenMovieMember),
            MyProfilePage(meAsGroupMember: meAsGroupMember),
            ...new List.generate(group.members.length, (index) => GroupMemberPage(groupMember: group.members[index])),
          ],
        );
      },
    );
  }

  GroupMember _setChosenMovieMember(Group group) {
    return groupController.getChosenMovieMember(group);
  }

  GroupMember _findUserLogged(Group group) {
    GroupMember userLogged;
    group.members.forEach((member) {
      if(member.uid == user.uid) {
        userLogged = member;
      }
    });
    return userLogged;
  }

  void _removeUserLoggedFromGroup(Group group, GroupMember meAsGroupMember) {
    group.members.remove(meAsGroupMember);
  }

}
