import 'package:flutter/material.dart';
import '../services/assets_manager.dart';
import './text.dart';
import '../constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatBox extends StatelessWidget {
  final String msg;
  final int index;
  ChatBox(this.msg, this.index);

  @override
  Widget build(BuildContext context) {
    print(msg);
    return Material(
      color: index == 0 ? ScaffoldBackgroundColor : CardColor,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              index == 0 ? AssetsManger.userImg : AssetsManger.chatImg,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: index == 0
                    ? TextBox(label: msg)
                    : DefaultTextStyle(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            totalRepeatCount: 1,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            animatedTexts: [TyperAnimatedText(msg.trim())]))),
            index == 0
                ? SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.thumb_down_alt_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
