import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/widgets/groupForm.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class NewGroupPage extends StatefulWidget {
  NewGroupPage({Key key}) : super(key: key);

  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: colorController.background,
            body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Center(
                          child: TitleText("nouveau groupe".toUpperCase(),
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Container(
                          child: GroupForm(),
                        ),
                      ),
                    ],
                  ),
                ))));;
  }

}