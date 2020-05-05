import 'dart:ui';

import 'package:onregardequoicesoir/constants/constants.dart' as Constants;

class ColorController {
  Color background;
  Color text;
  bool dark;

  ColorController() {
    this.background = Constants.dark;

    this.text = Constants.white;

    this.dark = true;
  }

  void changeColorMode() {
    dark = !dark;
    if (dark) {
      this.background = Constants.dark;
      this.text = Constants.white;
    } else {
      this.background = Constants.white;
      this.text = Constants.dark;
    }
  }
}

final ColorController colorController = new ColorController();
