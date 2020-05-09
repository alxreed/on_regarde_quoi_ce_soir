import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';

import 'group.dart';
import 'movie.dart';

class GroupMember extends User {
  bool turn;
  int position;

  GroupMember() {
    turn = false;
    position = 0;
    uid = '';
    surname = '';
    name = '';
    email = '';
    lastSeen = Timestamp.now();
    photoUrl = '';
    groups = new List<Group>();
    chosenMovie = Movie();
  }

  GroupMember.fromMap(dynamic map) {
    uid = map["uid"];
    surname = map["surname"];
    name = map["displayName"];
    email = map["email"];
    groups = generateGroups(map["groups"]);
    chosenMovie = generateChosenMovie(map["chosenMovie"]);
    lastSeen = map["lastSeen"];
    photoUrl = map["photoUrl"];
    turn = map["turn"];
    position = map["position"];
  }
}