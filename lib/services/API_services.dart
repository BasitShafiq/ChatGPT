import 'dart:convert';
import '../models/models_model.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constant.dart';
import '../models/chat_models.dart';

class APIServices {
  static Future<List<ModelsModel>> getModelsAPI() async {
    try {
      final url = "https://api.openai.com/v1/models";
      final res = await http
          .get(Uri.parse(url), headers: {"Authorization": 'Bearer $API_KEY'});
      final jsonResponse = jsonDecode(res.body);
       if (jsonResponse["error"] != null) {
        throw http.ClientException(jsonResponse["error"]["message"]);
      }
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
      }
      var lis = (ModelsModel.modelsFromSnapShot(temp));
      print(jsonResponse);
      return lis;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<List<chatModel>> sendMessage(
      {required String msg, required String model}) async {
    try {
      final url = "https://api.openai.com/v1/completions";
      final res = await http.post(Uri.parse(url),
          headers: {
            "Authorization": 'Bearer $API_KEY',
            "Content-Type": "application/json",
          },
          body: jsonEncode({"model": model, "prompt": msg, "max_tokens": 100}));
      final jsonResponse = jsonDecode(res.body);
      if (jsonResponse["error"] != null) {
        throw http.ClientException(jsonResponse["error"]["message"]);
      }
      List<chatModel> list = [];
      if (jsonResponse["choices"].length > 0) {
        print(jsonResponse["choices"][0]["text"]);
        list = List.generate(
            jsonResponse["choices"].length,
            (index) => chatModel(
                msg: jsonResponse["choices"][0]["text"], choicesIndex: 1));
      }
      print(jsonResponse);
      for (var i in list) {
        print(i);
      }
      return list;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
