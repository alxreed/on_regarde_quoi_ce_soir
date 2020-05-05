import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/views/loadingScreen.dart';

class OnRegardeQuoiCeSoir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'On Regarde Quoi Ce Soir',
      home: LoadingScreen(),
    );
  }
}