import 'dart:ui';

import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class ColorController {

  Color background;

  Color text;

  ColorController() {
    this.background = Constants.dark;

    this.text = Constants.white;
  }

  void darkMode() {
    background = Constants.dark;

    text = Constants.white;
  }

  void lightMode() {
    background = Constants.white;

    text = Constants.dark;
  }

}

final ColorController colorController = new ColorController();