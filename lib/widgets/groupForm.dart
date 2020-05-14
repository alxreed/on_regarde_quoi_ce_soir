import 'package:flutter/material.dart';
import 'package:onregardequoicesoir/controllers/colorController.dart';
import 'package:onregardequoicesoir/models/group.dart';
import 'package:onregardequoicesoir/constants/constants.dart' as Constants;


class GroupForm extends StatefulWidget {
  GroupForm({Key key}) : super(key: key);

  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  Group group = new Group();

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                hintText: "Tape le nom de ton groupe",
                hintStyle: TextStyle(color: Constants.grey),
                labelText: "Nom du groupe*",
                labelStyle: TextStyle(color: cursorColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Constants.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor)),
              ),
              onSaved: (value) {
                group.name = value;
              },
              validator: _validateName,
            ),
            sizedBoxSpace,
            RaisedButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                _handleSubmitted();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(color: Constants.red),
                child: Text(
                  "créer".toUpperCase(),
                  style: TextStyle(color: Constants.white),
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
      errorMsg = "Le nom de votre groupe ne peut pas être vide";
    }
    return errorMsg;
  }

  void _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      // TO DO CREER LE GROUPE
    }
  }


}