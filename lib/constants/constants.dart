import 'package:flutter/material.dart';
import '../widgets/text.dart';
import '../widgets/text.dart';

Color ScaffoldBackgroundColor = const Color(0xff343541);
Color CardColor = const Color(0xff444654);
List<String> models = ['Model1', 'Model2', 'Model3', 'Model4', 'Model5'];

List<DropdownMenuItem<String>> getModels() {
  return models.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: TextBox(
        label: value,
        fontSize: 15,
      ),
    );
  }).toList();
}

