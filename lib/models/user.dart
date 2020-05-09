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
  List<Group> groups;

  User() {
    uid = '';
    surname = '';
    name = '';
    email = '';
    lastSeen = Timestamp.now();
    photoUrl = '';
    groups = new List<Group>();
  }

  User.fromDocumentSnapshot(DocumentSnapshot documentUser) {
    if (documentUser != null) {
      Map<String, dynamic> map = documentUser.data;
      uid = map["uid"];
      surname = map["surname"];
      name = map["displayName"];
      email = map["email"];
      groups = new List<Group>();
      lastSeen = map["lastSeen"];
      photoUrl = map["photoUrl"];
    }
  }

  Future generateGroups(List<dynamic> uids) async {
    if (uids != null || uids.isNotEmpty) {
      uids.forEach((uid) async {
        Group group = await groupController.getGroup(uid);
        groups.add(group);
      });
    }
  }
}
