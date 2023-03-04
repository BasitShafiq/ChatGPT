import 'package:flutter/material.dart';
import '../models/models_model.dart';
import '../services/API_services.dart';

class ModelProvider with ChangeNotifier {
  String currModel = "text-davinci-001";
 
  void setModels(String curr) {
    currModel = curr;
    notifyListeners();
  }

  List<ModelsModel> _models = [];
  String get getCurrModel {
    return currModel;
  }

  List<ModelsModel> get getModels {
    return _models;
  }

  Future<List<ModelsModel>> getAllModels() async {
    _models = await APIServices.getModelsAPI();
    return _models;
  }
}
