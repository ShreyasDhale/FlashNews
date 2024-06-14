import 'package:flutter/material.dart';
import 'package:news_app/vars/globals.dart';

Widget customTextfield({
  required TextEditingController controller,
  required ValueChanged<String> onChanged, // Added onChanged parameter
  TextInputType type = TextInputType.name,
  Color borderColor = Colors.black,
  Color fillColor = Colors.white,
  String label = "Enter Text",
  bool keepBorder = true,
  bool enabled = true,
  bool multiLine = true,
  Widget leading = const SizedBox(),
  Widget trailing = const SizedBox(),
  TextStyle style = const TextStyle(), // Added default TextStyle
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    maxLines: multiLine ? null : 1,
    style: style,
    enabled: enabled,
    onChanged: (value) {
      onChanged(value);
      print(value);
    }, // Used the onChanged parameter
    decoration: InputDecoration(
      filled: true,
      fillColor: fillColor,
      focusColor: Colors.blue,
      labelText: label,
      labelStyle: style,
      prefixIcon: leading,
      suffixIcon: trailing,
      border: keepBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            )
          : InputBorder.none,
    ),
  );
}

Widget customPasswordfield(
    {required TextEditingController controller,
    TextInputType type = TextInputType.name,
    Color borderColor = Colors.black,
    String label = "Enter Text",
    Widget leading = const SizedBox(),
    Widget trailing = const SizedBox(),
    bool obsicure = true}) {
  return TextFormField(
    keyboardType: type,
    obscureText: obsicure,
    controller: controller,
    style: style,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.blue,
        labelText: label,
        labelStyle: style,
        prefixIcon: leading,
        suffixIcon: trailing,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(10))),
  );
}

Widget customButton(
    {required String text,
    required Function onTap,
    Color bgColor = Colors.blue,
    Color fgColor = Colors.white,
    Widget leading = const SizedBox(),
    double height = 50,
    double width = 600,
    bool loader = false,
    double borderRadius = 100}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        foregroundColor: fgColor,
        backgroundColor: bgColor,
        shadowColor: Colors.grey.shade800,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size.fromHeight(height),
      ),
      child: loader
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading,
                Text(
                  text,
                  style:
                      style.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
    ),
  );
}
