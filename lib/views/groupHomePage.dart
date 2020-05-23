import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/widgets/appBarOptions.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class GroupHomePage extends StatefulWidget {
  final GroupMember groupMember;

  GroupHomePage({Key key, this.groupMember}) : super(key: key);

  _GroupHomePageState createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
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
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: TitleText('on regarde ça'.toUpperCase(), fontSize: 25),
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                widget.groupMember.chosenMovie.title == ''
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TitleText(
                                "Le film n'a pas encore été choisi",
                                fontSize: 25),
                          ),
                        ),
                      )
                    : Text("les infos du films sont a mettre ici"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'choisi par',
                        style: TextStyle(color: colorController.text),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    NetworkImage(widget.groupMember.photoUrl),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.groupMember.surname,
                        style: TextStyle(
                            color: Constants.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
