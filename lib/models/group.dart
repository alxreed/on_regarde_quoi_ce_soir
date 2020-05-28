import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';
import 'package:onregardequoicesoir/models/user.dart';

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
    if (map != null) {
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

  void addMembersFromUsers(List<User> usersSelected) {
    int lastPositionMember = members.last.position;
    for (var i = 0; i < usersSelected.length; i++) {
      GroupMember groupMember = new GroupMember();

      groupMember.turn = false;
      groupMember.position = lastPositionMember + i + 1;
      groupMember.name = usersSelected[i].name;
      groupMember.email = usersSelected[i].email;
      groupMember.photoUrl = usersSelected[i].photoUrl;
      groupMember.surname = usersSelected[i].surname;
      groupMember.uid = usersSelected[i].uid;

      members.add(groupMember);
    }
  }
}
