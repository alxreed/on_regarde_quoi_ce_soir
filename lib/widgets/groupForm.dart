import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/userService.dart';
import 'package:onregardequoicesoir/utils/utils.dart';
import 'package:onregardequoicesoir/views/groupMenu.dart';

import 'loader.dart';

class GroupForm extends StatefulWidget {
  GroupForm({Key key}) : super(key: key);

  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  Group group = new Group();
  FirebaseUser userLogged;
  List<User> usersSelected;
  List<User> usersNotSelected;
  List<User> usersToDisplay;
  String query;

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    query = '';
    usersSelected = new List<User>();
    usersNotSelected = new List<User>();
    usersToDisplay = new List<User>();
    _initiateUserLogged();
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
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    sizedBoxSpace,
                    TextFormField(
                      style: TextStyle(color: cursorColor),
                      cursorColor: cursorColor,
                      decoration: InputDecoration(
                        filled: true,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: "Tape le nom de ton groupe",
                        hintStyle: TextStyle(color: Constants.grey),
                        labelText: "Nom du groupe*",
                        labelStyle: TextStyle(color: cursorColor),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Constants.grey)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: cursorColor)),
                      ),
                      onSaved: (value) {
                        group.name = value;
                      },
                      validator: _validateName,
                    ),
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
                        labelText: "Rechercher des membres",
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
/*                          if (isUserDisplay(
                              query, usersNotSelected[index].name))*/
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                color: Constants.red.withOpacity(0.50),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(usersSelected[index].photoUrl),
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
                                utils.capitalName(usersSelected[index].name),
                                style: TextStyle(color: colorController.text),
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
                              backgroundImage:
                                  NetworkImage(usersToDisplay[index].photoUrl),
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
                          "créer".toUpperCase(),
                          style: TextStyle(color: Constants.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String _validateName(String value) {
    String errorMsg;
    if (value.isEmpty) {
      errorMsg = "Le nom de votre groupe ne peut pas être vide";
    }
    return errorMsg;
  }

  void _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      await _addSelectedUsersToTheGroup(usersSelected);
      if (group.members.length == usersSelected.length + 1) {
        groupController.createGroup(group);
        // TO DO REDIRIGER VERS LE NOUVEAU GROUPE
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupMenu(
                      user: userLogged,
                    )));
      }
    }
  }

  Future<void> _initiateUserLogged() async {
    userLogged = await authService.userLogged;
    group.addMemberFromUid(userLogged.uid);
  }

  void _populateUsersNotSelected(AsyncSnapshot snapshot) {
    List<String> usersNotSelectedUID = new List<String>();
    usersNotSelected.forEach((user) => usersNotSelectedUID.add(user.uid));

    List<String> usersSelectedUID = new List<String>();
    usersSelected.forEach((user) => usersSelectedUID.add(user.uid));

    snapshot.data.documents.forEach((userSnap) {
      if (userSnap["uid"] != userLogged.uid &&
          !usersNotSelectedUID.contains(userSnap["uid"]) &&
          !usersSelectedUID.contains(userSnap["uid"])) {
        User user = User.fromDocumentSnapshot(userSnap);
        usersNotSelected.add(user);
      }
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

  Future<void> _addSelectedUsersToTheGroup(List<User> usersSelected) async {
    usersSelected.forEach((user) async {
      await group.addMemberFromUid(user.uid);
    });
  }
}
