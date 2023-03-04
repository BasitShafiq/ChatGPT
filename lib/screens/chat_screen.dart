import 'package:flutter/material.dart';
import '../services/assets_manager.dart';
import '../services/API_services.dart';
import '../constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/chatBox.dart';
import '../models/chat_models.dart';
import '../widgets/text.dart';
import '../widgets/drop_down.dart';
import '../provider/models_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = "/chat-screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textControler = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  List<chatModel> list = [];
  bool _isTyping = false;

  void automateScroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    //_textControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textControler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ModelProvider modeProvider =
        Provider.of<ModelProvider>(context, listen: false);
    String curr = modeProvider.getCurrModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManger.openaiLogo),
        ),
        title: Text("ChatGPT"),
        actions: [
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  backgroundColor: ScaffoldBackgroundColor,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(children: [
                        TextBox(
                          label: 'Choose Models ',
                          fontSize: 18,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Flexible(child: DropDownMenu(), flex: 2),
                      ]),
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (ctx, index) {
                return ChatBox(list[index].msg, list[index].choicesIndex);
              },
              itemCount: list.length,
            )),
            if (_isTyping)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 12,
                ),
              ),
            Material(
              color: CardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white, // Set the text color to red
                        ),
                        controller: _textControler,
                        onSaved: (value) {},
                        decoration: InputDecoration.collapsed(
                            hintText: "How can I help you?",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();
                        if (_isTyping) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: TextBox(label: "Wait for the Response!"),
                            ),
                          );
                          return;
                        }
                        if (_textControler.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: TextBox(
                                  label: "You cannot send empty Message!"),
                            ),
                          );
                          return;
                        }

                        String tempMsg = _textControler.text;
                        try {
                          setState(() {
                            _isTyping = true;
                            list.add(chatModel(msg: tempMsg, choicesIndex: 0));
                            _textControler.clear();
                          });

                          list.addAll(await APIServices.sendMessage(
                              msg: tempMsg, model: curr));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: TextBox(label: e.toString()),
                            ),
                          );
                          throw e;
                        } finally {
                          setState(() {
                            _isTyping = false;
                            automateScroll();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
