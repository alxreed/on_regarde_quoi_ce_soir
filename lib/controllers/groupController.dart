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

}

final GroupController groupController = new GroupController();