class chatModel {
  String msg;
  int choicesIndex;
  chatModel({required this.msg, required this.choicesIndex});

  factory chatModel.fromJson(Map<String, dynamic> json) => chatModel(
        msg: json["msg"],
        choicesIndex: json["choicesIndex"],
      );
}
