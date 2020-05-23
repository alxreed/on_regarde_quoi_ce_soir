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
        groupController.group = group;
        GroupMember chosenMovieMember = _setChosenMovieMember(group);
        GroupMember meAsGroupMember = _findUserLogged(group);
        List<GroupMember> groupMembersRemaining = _generateGroupMembersRemaning(group, meAsGroupMember);
        return PageView(
          controller: _controller,
          children: <Widget>[
            GroupHomePage(groupMember: chosenMovieMember),
            MyProfilePage(meAsGroupMember: meAsGroupMember),
            ...new List.generate(groupMembersRemaining.length, (index) => GroupMemberPage(groupMember: groupMembersRemaining[index])),
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

  List<GroupMember> _generateGroupMembersRemaning(Group group, GroupMember meAsGroupMember) {
    return group.members.where((member) => member.uid != meAsGroupMember.uid).toList();
  }
}
