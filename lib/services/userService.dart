import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';

class UserService {
  final Firestore _db = Firestore.instance;

  Stream getUser(String uid) {
    return _db.collection('users').document(uid).snapshots();
  }

}

final UserService userService = new UserService();
