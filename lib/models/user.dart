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
  Movie chosenMovie;

  User() {
    uid = '';
    surname = '';
    name = '';
    email = '';
    lastSeen = Timestamp.now();
    photoUrl = '';
    groups = new List<Group>();
    chosenMovie = Movie();
  }

  User.fromDocumentSnapshot(DocumentSnapshot documentUser) {
    Map<String, dynamic> map = documentUser.data;
    uid = map["uid"];
    surname = map["surname"];
    name = map["displayName"];
    email = map["email"];
    groups = generateGroups(map["groups"]);
    chosenMovie = generateChosenMovie(map["chosenMovie"]);
    lastSeen = map["lastSeen"];
    photoUrl = map["photoUrl"];
  }

  List<Group> generateGroups(List<dynamic> uids) {
    List<Group> listOfGroups = new List<Group>();
    uids.forEach((uid) {
      Group group = groupController.getGroup(uid);
    });
    return listOfGroups;
  }

  Movie generateChosenMovie(dynamic map) {
    Movie chosenMovie = new Movie();
    if (map != null) {
      chosenMovie = Movie.fromMap(map);
    }
    return chosenMovie;
  }
}