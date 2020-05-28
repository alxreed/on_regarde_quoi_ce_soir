import 'package:firebase_auth/firebase_auth.dart';
import 'package:onregardequoicesoir/controllers/userController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/models/user.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/services/groupService.dart';

class GroupController {

  Future<Group> getGroup(String uid) async {
    Group group = await groupService.getGroup(uid);
    return group;
  }

  void deleteGroup(String groupUid) {
    groupService.deleteGroup(groupUid);
  }

  void removeUserFromGroup(String groupUID, String userUID) {
    groupService.removeUserFromGroup(groupUID, userUID);
  }

  Future<String> createGroup(Group group) async {
    String newGroupUID = await groupService.createGroup(group);
    group.members.forEach((member) {
      userController.addGroupToUser(member.uid, newGroupUID);
    });

    return newGroupUID;
  }

  GroupMember getChosenMovieMember(Group group) {
    GroupMember chosenMovieMember;
    group.members.forEach((member) {
      if (member.turn) {
        chosenMovieMember = member;
      }
    });
    return chosenMovieMember;
  }

  void addNewMembersToTheGroup(Group group, List<User> usersSelected) {
    List<String> userSelectedUID = new List<String>();
    usersSelected.forEach((user) => userSelectedUID.add(user.uid));
    group.members.forEach((member) {
      if(userSelectedUID.contains(member.uid)) {
        userController.addGroupToUser(member.uid, group.uid);
        groupService.addNewMembersToTheGroup(member, group.uid);
      }
    });
  }
}

final GroupController groupController = new GroupController();
