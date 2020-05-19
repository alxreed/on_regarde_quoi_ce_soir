import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/user.dart';

class UserService {
  final Firestore _db = Firestore.instance;

  Stream getUser(String uid) {
    return _db.collection('users').document(uid).snapshots();
  }

  void removeGroupFromUser(String userUID, String groupUID) {
    _db.collection('users').document(userUID).updateData({
      "groups": FieldValue.arrayRemove([groupUID])
    });
  }

  Future<Map<String, dynamic>> getUserMap(String uid) async {
    DocumentSnapshot snapshot = await _db.collection('users').document(uid).get();
    Map<String, dynamic> map = snapshot.data;
    return map;
  }

  Stream allUsersStream() {
    return _db.collection('users').snapshots();
  }

  void addGroupToUser(String uid, String newGroupUID) {
    _db.collection('users').document(uid).updateData({
      'groups': FieldValue.arrayUnion([newGroupUID])
    });
  }

}

final UserService userService = new UserService();
