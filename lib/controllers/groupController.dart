import 'package:onregardequoicesoir/controllers/userController.dart';
import 'package:onregardequoicesoir/models/group.dart';
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

  void createGroup(Group group) async {
    String newGroupUID = await groupService.createGroup(group);

    group.members.forEach((member) {userController.addGroupToUser(member.uid, newGroupUID);});
  }

}

final GroupController groupController = new GroupController();