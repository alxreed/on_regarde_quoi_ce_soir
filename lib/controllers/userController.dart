import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';

class UserController {
  Future<User> createUser(DocumentSnapshot documentUser) async {
    User user = User.fromDocumentSnapshot(documentUser);
    return user;
  }
}

final UserController userController = new UserController();
