import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/services/groupService.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class ListMenuTile extends StatefulWidget {
  final String groupUID;

  ListMenuTile({Key key, this.groupUID}) : super(key: key);

  _ListMenuTileState createState() => _ListMenuTileState();
}

class _ListMenuTileState extends State<ListMenuTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groupService.getStreamGroup(widget.groupUID),
      builder: (context, snapshot) {
        DocumentSnapshot documentSnapshot = snapshot.data;
        Group group = Group.fromSnapshot(documentSnapshot);
        return GestureDetector(
          child: Container(
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      group.name.toUpperCase(),
                      fontSize: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text("Membres: ", style: TextStyle(color: Constants.grey),),
                        ...new List.generate(
                            group.members.length,
                            (index) => Text(
                                "${group.members[index].surname}, ", style: TextStyle(color: Constants.grey),))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
