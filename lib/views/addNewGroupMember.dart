import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/userService.dart';
import 'package:onregardequoicesoir/utils/utils.dart';
import 'package:onregardequoicesoir/widgets/loader.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

import 'groupRoutingPage.dart';

class AddNewGroupMember extends StatefulWidget {
  final Group group;

  AddNewGroupMember({Key key, this.group}) : super(key: key);

  _AddNewGroupMemberState createState() => _AddNewGroupMemberState();
}

class _AddNewGroupMemberState extends State<AddNewGroupMember> {
  String query;
  List<User> usersToDisplay;
  List<User> usersSelected;
  List<User> usersNotSelected;

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    query = '';
    usersToDisplay = new List<User>();
    usersSelected = new List<User>();
    usersNotSelected = new List<User>();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(
      height: 24,
    );
    Color cursorColor = colorController.text;

    return StreamBuilder(
        stream: userService.allUsersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loader();
          _populateUsersNotSelected(snapshot);
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
                            labelText: "Rechercher des nouveaux membres",
                            labelStyle: TextStyle(color: cursorColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constants.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: cursorColor)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                              usersToDisplay = queryingUsers(query);
                            });
                          },
                        ),
                        sizedBoxSpace,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: usersSelected.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                    color: Constants.red.withOpacity(0.50),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        usersSelected[index].photoUrl),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      _removeUser(usersSelected[index]);
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: colorController.text,
                                    ),
                                  ),
                                  title: Text(
                                    utils
                                        .capitalName(usersSelected[index].name),
                                    style:
                                        TextStyle(color: colorController.text),
                                  ),
                                ),
                              );
                              return null;
                            }),
                        sizedBoxSpace,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: usersToDisplay.length,
                            itemBuilder: (context, index) {
/*                          if (isUserDisplay(
                              query, usersNotSelected[index].name))*/
                              return ListTile(
                                onTap: () {
                                  _addUser(usersToDisplay[index]);
                                  _controller.clear();
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      usersToDisplay[index].photoUrl),
                                ),
                                title: Text(
                                  utils.capitalName(usersToDisplay[index].name),
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
                              "Ajouter".toUpperCase(),
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

  List<User> queryingUsers(String query) {
    List<User> usersToDisplay = new List<User>();
    usersNotSelected.forEach((user) {
      if (isUserDisplay(query, user.name)) {
        usersToDisplay.add(user);
      }
    });
    return usersToDisplay;
  }

  void _addUser(User userToAdd) {
    setState(() {
      usersSelected.add(userToAdd);
      usersNotSelected.remove(userToAdd);
      usersToDisplay.remove(userToAdd);
    });
  }

  void _removeUser(User usersToRemove) {
    setState(() {
      usersNotSelected.add(usersToRemove);
      usersSelected.remove(usersToRemove);
      usersToDisplay.add(usersToRemove);
    });
  }

  bool isUserDisplay(String query, String userName) {
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
      _addSelectedUsersToTheGroup(usersSelected);
      groupController.addNewMembersToTheGroup(widget.group, usersSelected);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupRoutingPage(group: widget.group)));
    }
  }

  void _addSelectedUsersToTheGroup(List<User> usersSelected) {
    widget.group.addMembersFromUsers(usersSelected);
  }

  void _populateUsersNotSelected(AsyncSnapshot snapshot) {
    List<String> usersNotSelectedUID = new List<String>();
    usersNotSelected.forEach((user) => usersNotSelectedUID.add(user.uid));

    List<String> usersSelectedUID = new List<String>();
    usersSelected.forEach((user) => usersSelectedUID.add(user.uid));

    List<String> currentMembersUID = new List<String>();
    widget.group.members.forEach((member) => currentMembersUID.add(member.uid));

    snapshot.data.documents.forEach((userSnap) {
      if (!currentMembersUID.contains(userSnap["uid"]) &&
          !usersNotSelectedUID.contains(userSnap["uid"]) &&
          !usersSelectedUID.contains(userSnap["uid"])) {
        User user = User.fromDocumentSnapshot(userSnap);
        usersNotSelected.add(user);
      }
    });
  }
}
