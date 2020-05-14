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
}

final UserController userController = new UserController();
