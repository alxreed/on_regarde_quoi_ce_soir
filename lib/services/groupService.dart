import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/group.dart';

class GroupService {
  final Firestore _db = Firestore.instance;

  Group getGroup(String uid) {
    Group group;
    _db.collection('groups').document(uid).snapshots().listen((data) {
      print("service");
      print(uid);
      print(data.data);
    });
    return group;
  }

}

final GroupService groupService = new GroupService();