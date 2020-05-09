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
    uid = map["uid"];
    name = map["name"];
    members = generateMembers(map["members"]);
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
}