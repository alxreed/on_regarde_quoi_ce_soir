import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/services/authService.dart';


class GroupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: colorController.background, body: FloatingActionButton(onPressed: (() => authService.signOut())),);
  }

}