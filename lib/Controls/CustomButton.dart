import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required String this.ButtonLabel,
    required Function() this.onPressed,
    double? this.height,
    double? this.width = double.maxFinite,
    double this.margin = 10,
    double this.radius = 20,
    double? this.fontSize = 20,
  }) : super(key: key);

  final String ButtonLabel;
  final double margin;
  final double radius;
  final Function() onPressed;

  final double? height;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: ElevatedButton(
          onPressed: () {
            print("Button Clicked");
            this.onPressed();
          },
          child: Center(
            child: Text(ButtonLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  height: height ?? 1,
                  letterSpacing: 0,
                )),
          )),
    );
  }
}
