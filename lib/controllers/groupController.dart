import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/services/groupService.dart';

class GroupController {

  Group getGroup(String uid) {
    Group group;
    groupService.getGroup(uid);
    return group;
  }

}

final GroupController groupController = new GroupController();