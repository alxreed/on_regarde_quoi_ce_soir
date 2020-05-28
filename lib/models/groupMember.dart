import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';
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
  String photoUrl;
  Movie chosenMovie;

  GroupMember() {
    turn = false;
    position = 0;
    uid = '';
    surname = '';
    name = '';
    email = '';
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
    turn = generateTurn(map["turn"]);
    position = generatePosition(map["position"]);
  }

  Movie generateChosenMovie(dynamic map) {
    Movie chosenMovie = new Movie();
    if (map != null) {
      chosenMovie = Movie.fromMap(map);
    }
    return chosenMovie;
  }

  bool generateTurn(turnMap) {
    bool turn = true;
      if (turnMap != null) {
        turn = turnMap;
      }
    return turn;
  }

  int generatePosition(intMap) {
    int position = 1;
      if (intMap != null) {
        position = intMap;
      }
    return position;
  }
}
