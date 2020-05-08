import 'package:flutter/cupertino.dart';
import 'package:onregardequoicesoir/views/loginPage.dart';
import 'package:onregardequoicesoir/views/registerPage.dart';

class RoutingLoginRegister extends StatefulWidget {
  RoutingLoginRegister({Key key}) : super(key: key);

  @override
  _RoutingLoginRegisterState createState() => _RoutingLoginRegisterState();
}

class _RoutingLoginRegisterState extends State<RoutingLoginRegister> {

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: <Widget>[
        LoginPage(),
        RegisterPage(),
      ],
    );
  }

}