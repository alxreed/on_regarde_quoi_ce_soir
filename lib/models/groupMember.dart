import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';

import 'group.dart';
import 'movie.dart';

class GroupMember {
  bool turn;
  int position;
  String uid;
  String surname;
  String name;
  String email;
  Timestamp lastSeen;
  String photoUrl;
  Movie chosenMovie;

  GroupMember() {
    turn = false;
    position = 0;
    uid = '';
    surname = '';
    name = '';
    email = '';
    lastSeen = Timestamp.now();
    photoUrl = '';
    chosenMovie = Movie();
  }

  GroupMember.fromMap(dynamic map) {
    uid = map["uid"];
    surname = map["surname"];
    name = map["displayName"];
    email = map["email"];
    chosenMovie = generateChosenMovie(map["chosenMovie"]);
    photoUrl = map["photoUrl"];
    turn = map["turn"];
    position = map["position"];
  }

  Movie generateChosenMovie(dynamic map) {
    Movie chosenMovie = new Movie();
    if (map != null) {
      chosenMovie = Movie.fromMap(map);
    }
    return chosenMovie;
  }
}