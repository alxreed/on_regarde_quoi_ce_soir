import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.cursorColor,
  });

  final Color cursorColor;
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      key: widget.fieldKey,
      obscureText: _obscureText,
      cursorColor: widget.cursorColor,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        icon: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[700]),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[700])),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        helperText: widget.helperText,
        helperStyle: TextStyle(color: Colors.white),
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}