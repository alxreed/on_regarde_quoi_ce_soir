import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/groupMember.dart';
import 'package:onregardequoicesoir/widgets/appBarOptions.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class MyProfilePage extends StatefulWidget {
  final GroupMember meAsGroupMember;

  MyProfilePage({Key key, this.meAsGroupMember}) : super(key: key);

  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
                      image: NetworkImage(widget.meAsGroupMember.photoUrl),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: TitleText('votre film'.toUpperCase(), fontSize: 25),
              ),
            ),
            widget.meAsGroupMember.chosenMovie.title == ''
                ? Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: TitleText(
                            "Vous n'avez pas encore choisi de film",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.red,
        onPressed: () {
          // TODO RECHERCHER UN FILM
        },
        child: Icon(
          Icons.search,
          color: Constants.white,
        ),
      ),
    ));
  }
}
