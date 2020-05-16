import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';

import 'groupMember.dart';

class Group {
  String uid;
  String name;
  List<GroupMember> members;

  Group() {
    uid = '';
    name = '';
    members = new List<GroupMember>();
  }

  Group.fromMap(dynamic map) {
    if(map != null) {
      uid = map["uid"];
      name = map["name"];
      members = generateMembers(map["members"]);
    }
  }
  Group.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      Map<String, dynamic> map = snapshot.data;
      uid = map["uid"];
      name = map["name"];
      members = generateMembers(map["members"]);
    }
  }


  List<GroupMember> generateMembers(List<dynamic> list) {
    List<GroupMember> members = new List<GroupMember>();
    if (list != null || list.isNotEmpty) {
      list.forEach((memberMap) {
        GroupMember groupMember = GroupMember.fromMap(memberMap);
        members.add(groupMember);
      });
    }
    return members;
  }

  Future<void> addMemberFromUid(String uid) async {
    Map<String, dynamic> map = await userController.getUserMap(uid);
    GroupMember member = GroupMember.fromMap(map);
    members.add(member);

  }
}