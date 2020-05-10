import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onregardequoicesoir/controllers/groupController.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';

import 'group.dart';
import 'movie.dart';

class User {
  String uid;
  String surname;
  String name;
  String email;
  Timestamp lastSeen;
  String photoUrl;
  List<String> groupsUIDs;

  User() {
    uid = '';
    surname = '';
    name = '';
    email = '';
    lastSeen = Timestamp.now();
    photoUrl = '';
    groupsUIDs = new List<String>();
  }

  User.fromDocumentSnapshot(DocumentSnapshot documentUser) {
    if (documentUser != null) {
      Map<String, dynamic> map = documentUser.data;
      uid = map["uid"];
      surname = map["surname"];
      name = map["displayName"];
      email = map["email"];
      groupsUIDs = generateGroupsUIDs(map["groups"]);
      lastSeen = map["lastSeen"];
      photoUrl = map["photoUrl"];
    }
  }

  generateGroupsUIDs(List<dynamic> uids) {
    List<String> listOfUIDs = new List<String>();
    if (uids != null || uids.isNotEmpty) {
      uids.forEach((uid) => listOfUIDs.add(uid));
    }
    return listOfUIDs;
  }

  Future<List<Group>> generateGroups(List<dynamic> uids) async {
    List<Group> listOfGroups = new List<Group>();
    if (uids != null || uids.isNotEmpty) {
      uids.forEach((uid) async {
        Group group = await groupController.getGroup(uid);
        listOfGroups.add(group);
      });
    }
    return listOfGroups;
  }
}
