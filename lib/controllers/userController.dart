import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/userService.dart';

class UserController {
  Future<User> createUser(DocumentSnapshot documentUser) async {
    User user = User.fromDocumentSnapshot(documentUser);
    return user;
  }

  void removeGroupFromUser(String userUID, String groupUID) {
    userService.removeGroupFromUser(userUID, groupUID);
  }

  getUserMap(String uid) async {
    Map<String, dynamic> map = await userService.getUserMap(uid);
    return map;
  }

  void addGroupToUser(String uid, String newGroupUID) {
    userService.addGroupToUser(uid, newGroupUID);
  }
}

final UserController userController = new UserController();
