import 'package:flutter/material.dart';

class CustomTextEntryField extends StatefulWidget {
  CustomTextEntryField(
      {Key? key,
      String? this.hintText,
      Widget? this.IconWidget,
      bool this.isPassword = false,
      Color this.buttonBackgroundColor = const Color.fromRGBO(9, 53, 69, 1),
      Color this.borderColor = Colors.white,
      Color this.textColor = Colors.white,
      int this.maxLine = 1,
      double this.width = double.maxFinite,
      double? this.hieght,
      double? this.borderRadius = 5,
      double this.fontSize = 15,
      double this.contentPadding = 10,
      double this.hintFontSize = 15,
      TextInputType this.keyboardType = TextInputType.text,
      TextEditingController? this.inptcontroller})
      : super(key: key);

  String? hintText;
  Widget? IconWidget;
  int maxLine;
  bool isPassword;
  Color buttonBackgroundColor;
  Color borderColor;
  Color textColor;
  double width;
  double? hieght;
  double? borderRadius;
  double fontSize;
  double hintFontSize;
  double contentPadding;
  TextInputType keyboardType;
  TextEditingController? inptcontroller;
  @override
  State<CustomTextEntryField> createState() => _CustomTextEntryFieldState();
}

class _CustomTextEntryFieldState extends State<CustomTextEntryField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inptcontroller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLine,
      autofocus: true,
      style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
      obscureText: widget.isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          print("Validation Failed");
          return "Enter Full Name";
        } else {
          print("Validation worked");
          return null;
        }
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: widget.buttonBackgroundColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(color: widget.borderColor, width: 3)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(color: widget.borderColor)),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          hintText: widget.hintText,
          hintStyle:
              TextStyle(fontSize: widget.hintFontSize, color: Colors.white38),
          contentPadding: EdgeInsets.all(widget.contentPadding),
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
