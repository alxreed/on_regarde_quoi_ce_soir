import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/services/userService.dart';

class GroupService {

  Group group;

  GroupService() {
    group = new Group();
  }

  final Firestore _db = Firestore.instance;

  Future<Group> getGroup(String uid) async {
    Group group;
    DocumentSnapshot snapshot =
        await _db.collection('groups').document(uid).get();
    group = Group.fromMap(snapshot.data);
    return group;
  }

  Future<List<Group>> getGroups(List<dynamic> uids) async {
    List<Group> listOfGroups = new List<Group>();
    uids.forEach((uid) async {
      Group group = await getGroup(uid);
      listOfGroups.add(group);
    });
    return listOfGroups;
  }

  Stream<QuerySnapshot> getUserGroups(String userUID) {
    _db.collection('groups').where("members", arrayContains: {"uid": userUID});
  }

  Stream getStreamGroup(String uid) {
    return _db.collection('groups').document(uid).snapshots();
  }

  void deleteGroup(String groupUid) {
    _db.collection('groups').document(groupUid).delete();
  }

  Future<void> removeUserFromGroup(String groupUID, String userUID) async {
    DocumentReference groupRef = _db.collection('groups').document(groupUID);
    DocumentSnapshot groupSnap = await groupRef.get();

    List<dynamic> members = groupSnap.data["members"];
    members.removeWhere((member) => member["uid"] == userUID);

    return groupRef.updateData({'members': members});
  }

  Future<String> createGroup(Group group) async {
    group.members.forEach((element) {
      print(element.name);
    });

    List<dynamic> groupMembers = new List<dynamic>();

    for (var i = 0; i < group.members.length; i++) {
      HashMap<dynamic, dynamic> memberMap = new HashMap<dynamic, dynamic>();

      memberMap["turn"] = group.members[i].turn;
      memberMap["position"] = group.members[i].position;
      memberMap["displayName"] = group.members[i].name;
      memberMap["email"] = group.members[i].email;
      memberMap["photoUrl"] = group.members[i].photoUrl;
      memberMap["surname"] = group.members[i].surname;
      memberMap["uid"] = group.members[i].uid;

      groupMembers.add(memberMap);
    }

    DocumentReference groupRef = await _db
        .collection('groups')
        .add({'name': group.name, 'members': groupMembers});

    groupRef.updateData({'uid': groupRef.documentID});

    return groupRef.documentID;
  }

  void addNewMembersToTheGroup(GroupMember member, String uid) {
    DocumentReference groupRef = _db.collection('groups').document(uid);
    HashMap<dynamic, dynamic> memberMap = new HashMap<dynamic, dynamic>();

    memberMap["turn"] = member.turn;
    memberMap["position"] = member.position;
    memberMap["displayName"] = member.name;
    memberMap["email"] = member.email;
    memberMap["photoUrl"] = member.photoUrl;
    memberMap["surname"] = member.surname;
    memberMap["uid"] = member.uid;
    
    groupRef.updateData({'members': FieldValue.arrayUnion([memberMap])});
  }
  
}

final GroupService groupService = new GroupService();
