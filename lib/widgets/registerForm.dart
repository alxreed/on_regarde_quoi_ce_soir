import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/registerData.dart';
import 'package:onregardequoicesoir/services/authService.dart';
import 'package:onregardequoicesoir/widgets/passwordField.dart';
import 'package:onregardequoicesoir/widgets/titleText.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  RegisterData registerData = RegisterData();

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(
      height: 24,
    );
    Color cursorColor = colorController.text;

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: "Tape ton nom ou ton pseudo",
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Nom*",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              onSaved: (value) {
                registerData.name = value;
              },
              validator: _validateName,
            ),
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "Tape ton adresse email",
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Email*",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                registerData.email = value;
              },
              validator: _validateEmail,
            ),
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
                hintText: "Tape l'url de ta photo de profil",
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Photo de profil",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              onSaved: (value) {
                registerData.photoUrl = value;
              },
              validator: _validatePhotoUrl,
            ),
            sizedBoxSpace,
            PasswordField(
              cursorColor: cursorColor,
              fieldKey: _passwordFieldKey,
              hintText: "Tape ton mot de passe",
              helperText: "8 caractères minimum",
              labelText: "Mot de passe",
              onSaved: (value) {
                registerData.password = value;
              },
            ),
            sizedBoxSpace,
            TextFormField(
              style: TextStyle(color: cursorColor),
              cursorColor: cursorColor,
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(
                  Icons.lock,
                  color: Color(0xFF212121),
                ),
                hintStyle: TextStyle(color: Colors.grey[700]),
                labelText: "Retape ton mot de passesss",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              obscureText: true,
              validator: _validatePassword,
            ),
            sizedBoxSpace,
            RaisedButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                _handleSubmitted();
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: cursorColor),
                child: Text(
                  "inscription".toUpperCase(),
                  style: TextStyle(color: colorController.background),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateName(String value) {
    String errorMsg;
    if (value.isEmpty) {
      errorMsg = "Votre nom ne peut être vide";
    }
    return errorMsg;
  }

  String _validateEmail(String value) {
    String errorMsg;
    if (value.isEmpty) {
      errorMsg = "Votre adresse email ne peut être vide";
    }
    final emailExp = RegExp(
        r'^[^\W][a-zA-Z0-9_]+(\.[a-zA-Z0-9_]+)*\@[a-zA-Z0-9_]+(\.[a-zA-Z0-9_]+)*\.[a-zA-Z]{2,4}$');
    if (!emailExp.hasMatch(value)) {
      errorMsg = "Vous devez renseigner une adresse valide";
    }
    return errorMsg;
  }

  String _validatePhotoUrl(String value) {
    String errorMsg;
    if (value.isNotEmpty) {
      final urlExp = RegExp(
          r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$");
      if (!urlExp.hasMatch(value)) {
        errorMsg = "Vous devez renseigner une url valide";
      }
    }
    return errorMsg;
  }

  String _validatePassword(String value) {
    String errorMsg;
    final passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null ||
        passwordField.value.isEmpty ||
        passwordField.value.length < 8) {
      errorMsg = "Veuillez renseigner un mot de passe valide";
    }
    if (passwordField.value != value) {
      errorMsg = "Vous de vez taper le même mot de passe";
    }
    return errorMsg;
  }

  void _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      authService.registerUser(registerData).catchError((error) {
        if (error is PlatformException) {
          if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {}
          final snackBar =
              SnackBar(content: Text('Cet utilisateur existe déjà'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      });
    }
  }
}
