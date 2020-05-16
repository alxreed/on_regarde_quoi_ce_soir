import 'package:basic_utils/basic_utils.dart';

class Utils {
  String capitalName(String fullName) {
    List<String> nameAndSurname = fullName.split(' ');
    List<String> nameAndSurnameCapitalized = new List<String>();
    nameAndSurname.forEach((namePart) {
      namePart = StringUtils.capitalize(namePart);
      nameAndSurnameCapitalized.add(namePart);
    });

    return nameAndSurnameCapitalized.join(" ");
  }
}

final Utils utils = new Utils();
