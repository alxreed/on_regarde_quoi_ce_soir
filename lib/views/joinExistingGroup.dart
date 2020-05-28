import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/services/userService.dart';
import 'package:onregardequoicesoir/utils/utils.dart';
import 'package:onregardequoicesoir/widgets/loader.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

import 'groupRoutingPage.dart';

class JoinExistingGroup extends StatefulWidget {
  JoinExistingGroup({Key key}) : super(key: key);

  _JoinExistingGroupState createState() => _JoinExistingGroupState();
}

class _JoinExistingGroupState extends State<JoinExistingGroup> {
  String query;
  List<Group> groupsToDisplay;
  Group groupSelected;
  List<Group> groupsNotSelected;
  User userLogged;
  List<User> usersSelected;

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    query = '';
    groupsToDisplay = new List<Group>();
    groupsNotSelected = new List<Group>();
    usersSelected = new List<User>();
    _initiateUserLogged(authService.userSet.uid);
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(
      height: 24,
    );
    Color cursorColor = colorController.text;

    return StreamBuilder(
        stream: groupService.allGroupsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loader();
          _populateGroupsNotSelected(snapshot);
          return SafeArea(
            child: Scaffold(
              backgroundColor: colorController.background,
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        sizedBoxSpace,
                        TextFormField(
                          controller: _controller,
                          style: TextStyle(color: cursorColor),
                          cursorColor: cursorColor,
                          decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(
                              MaterialCommunityIcons.account_search,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(color: Constants.grey),
                            labelText: "Rechercher un groupe",
                            labelStyle: TextStyle(color: cursorColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constants.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: cursorColor)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                              groupsToDisplay = queryingGroups(query);
                            });
                          },
                        ),
                        if (groupSelected != null) sizedBoxSpace,
                        if (groupSelected != null)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                color: Constants.red.withOpacity(0.50),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    groupSelected.members[0].photoUrl),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  _removeGroup(groupSelected);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: colorController.text,
                                ),
                              ),
                              title: Text(
                                utils.capitalName(groupSelected.name),
                                style: TextStyle(color: colorController.text),
                              ),
                            ),
                          ),
                        sizedBoxSpace,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: groupsToDisplay.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  _addUser(groupsToDisplay[index]);
                                  _controller.clear();
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      groupsToDisplay[index]
                                          .members[0]
                                          .photoUrl),
                                ),
                                title: Text(
                                  utils
                                      .capitalName(groupsToDisplay[index].name),
                                  style: TextStyle(color: colorController.text),
                                ),
                              );
                              return null;
                            }),
                        sizedBoxSpace,
                        RaisedButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            _handleSubmitted();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(color: Constants.red),
                            child: Text(
                              "Rejoindre ce groupe".toUpperCase(),
                              style: TextStyle(color: Constants.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Group> queryingGroups(String query) {
    List<Group> groupsToDisplay = new List<Group>();
    groupsNotSelected.forEach((group) {
      if (isGroupDisplay(query, group.name)) {
        groupsToDisplay.add(group);
      }
    });
    return groupsToDisplay;
  }

  void _addUser(Group groupToAdd) {
    setState(() {
      groupSelected = groupToAdd;
      groupsNotSelected.remove(groupToAdd);
      groupsToDisplay.remove(groupToAdd);
    });
  }

  void _removeGroup(Group groupToRemove) {
    setState(() {
      groupsNotSelected.add(groupToRemove);
      groupSelected = null;
      groupsToDisplay.add(groupToRemove);
    });
  }

  bool isGroupDisplay(String query, String userName) {
    bool isDisplay = false;
    query = query.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s|\s|\b"), "");
    userName =
        userName.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s|\s|\b"), "");
    if (query.isEmpty) return isDisplay;
    if (userName.contains(query)) {
      isDisplay = true;
    }
    return isDisplay;
  }

  void _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      usersSelected.add(userLogged);
      _addSelectedUsersToTheGroup(usersSelected);
      groupController.addNewMembersToTheGroup(groupSelected, usersSelected);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupRoutingPage(group: groupSelected)));
    }
  }

  void _addSelectedUsersToTheGroup(List<User> usersSelected) {
    groupSelected.addMembersFromUsers(usersSelected);
  }

  void _populateGroupsNotSelected(AsyncSnapshot snapshot) {
    List<String> groupsNotSelectedUID = new List<String>();
    groupsNotSelected.forEach((group) => groupsNotSelectedUID.add(group.uid));

    snapshot.data.documents.forEach((groupSnap) {
      if (!userLogged.groupsUIDs.contains(groupSnap["uid"]) &&
          !groupsNotSelectedUID.contains(groupSnap["uid"])) {
        Group group = Group.fromSnapshot(groupSnap);
        groupsNotSelected.add(group);
        if (groupSelected != null && groupSelected.uid == groupSnap["uid"]) {
          print("onest la");
          groupsNotSelected.remove(group);
        }
      }
    });
  }

  void _initiateUserLogged(String uid) async {
    userLogged = User.fromMap(await userService.getUserMap(uid));
  }
}
