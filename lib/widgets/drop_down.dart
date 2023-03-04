import 'package:chat_gpt/models/models_model.dart';
import '../widgets/text.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../services/API_services.dart';
import '../provider/models_provider.dart';
import 'package:provider/provider.dart';

class DropDownMenu extends StatefulWidget {
  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    ModelProvider modeProvider =
        Provider.of<ModelProvider>(context, listen: false);
    String curr = modeProvider.getCurrModel;

    return FutureBuilder<List<ModelsModel>>(
        future: modeProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data to be fetched from database
            return CircularProgressIndicator();
          }
          return FittedBox(
            child: DropdownButton<String>(
              dropdownColor: ScaffoldBackgroundColor,
              value: curr,
              onChanged: (newValue) {
                setState(() {
                  modeProvider.setModels(newValue!);
                });
              },
              items: snapshot.data!.map((model) {
                return DropdownMenuItem<String>(
                  value: model.root,
                  child: TextBox(label: (model.root)),
                );
              }).toList(),
            ),
          );
        });
  }
}
