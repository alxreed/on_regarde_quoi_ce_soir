import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/widgets/appBarOptions.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class GroupMemberPage extends StatefulWidget {
final GroupMember groupMember;

GroupMemberPage({Key key, this.groupMember}) : super(key: key);

  _GroupMemberPageState createState() => _GroupMemberPageState();
}

class _GroupMemberPageState extends State<GroupMemberPage> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: colorController.background,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: AppBarOptions(
                    canAddFriends: true,
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(widget.groupMember.photoUrl),
                          fit: BoxFit.cover)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Center(
                    child: TitleText(widget.groupMember.surname.toUpperCase(), fontSize: 25),
                  ),
                ),
                widget.groupMember.chosenMovie.title == ''
                    ? Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: TitleText(
                          "${StringUtils.capitalize(widget.groupMember.surname)} n'a pas encore choisi de film",
                          fontSize: 25),
                    ),
                  ),
                )
                    : Expanded(
                    child: Column(
                      children: <Widget>[
                        // TODO LES DETAILS DU FILM
                      ],
                    ))
              ],
            ),
          ),
        ));

  }


}