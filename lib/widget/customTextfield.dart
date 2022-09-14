import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.textEditingController,
      this.label = "",
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.isNumeric = false,
      required this.onChanged,
      this.fontSize = 17})
      : super(key: key);
  final TextEditingController? textEditingController;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool isNumeric;
  final void Function(String) onChanged;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey[800],
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400),
      onChanged: onChanged,
      inputFormatters: isNumeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : [],
      maxLength: isNumeric ? 8 : null,
      enableInteractiveSelection: false,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC2232C)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: label,
          prefix: isNumeric ? Text("+65") : null),
    );
  }
}
