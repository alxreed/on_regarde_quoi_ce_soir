import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/group.dart';

class GroupService {
  final Firestore _db = Firestore.instance;

  Future<Group> getGroup(String uid) async {
    Group group;
    DocumentSnapshot snapshot = await _db.collection('groups').document(uid).get();
    group = Group.fromMap(snapshot.data);
    return group;
  }

}

final GroupService groupService = new GroupService();