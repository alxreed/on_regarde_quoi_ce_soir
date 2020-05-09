import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/services/authService.dart';

class AppBarOptions extends StatefulWidget {
  AppBarOptions({Key key}) : super(key: key);

  _AppBarOptionsState createState() => _AppBarOptionsState();
}

class _AppBarOptionsState extends State<AppBarOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: FittedBox(
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    colorController.changeColorMode();
                  });
                },
                child: Icon(
                  colorController.dark ? MaterialIcons.wb_sunny : MaterialCommunityIcons.moon_first_quarter,
                  color: colorController.text,
                  size: 60,
                )),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.60,),
        Container(
          height: 50,
          width: 50,
          child: FittedBox(
              child: FlatButton(
                onPressed: () => authService.signOut(),
                child: Icon(
                  MaterialCommunityIcons.power_standby,
                  color: colorController.text,
                  size: 60,
                ),
              )),
        ),
      ],
    );
  }

}