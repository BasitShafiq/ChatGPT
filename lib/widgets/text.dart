import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final FontWeight? fontWeight;
  final double? fontSize;
  TextBox({
    required this.label,
    this.fontWeight,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
