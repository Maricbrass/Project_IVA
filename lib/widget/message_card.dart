import 'package:testiva/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../helper/global.dart';
import '../model/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final bool isFromUser;
  final Color backgroundColor;

  const MessageCard({
    required Key key,
    required this.message,
    required this.isFromUser,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);

    return message.msgType == MessageType.bot

        //bot
        ? Row(children: [
            const SizedBox(width: 6),

            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/logo.png', width: 24),
            ),

            //
            Container(
              constraints: BoxConstraints(maxWidth: mq.width * .6),
              margin: EdgeInsets.only(
                  bottom: mq.height * .02, left: mq.width * .02),
              padding: EdgeInsets.symmetric(
                  vertical: mq.height * .01, horizontal: mq.width * .02),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).lightTextColor),
                  borderRadius: const BorderRadius.only(
                      topLeft: r, topRight: r, bottomRight: r),
              color: Theme.of(context).bottextColor,
              ),

              child: message.msg.isEmpty
                  ? AnimatedTextKit(animatedTexts: [
                      TypewriterAnimatedText(
                        ' Please wait... ',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ], repeatForever: true)
                  : AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText(
                          message.msg,
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 100),
                        ),
                      ], repeatForever: false,totalRepeatCount: 1,)),
          ])

        //user
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //
            Container(
                constraints: BoxConstraints(maxWidth: mq.width * .6),
                margin: EdgeInsets.only(
                    bottom: mq.height * .02, right: mq.width * .02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .02),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).lightTextColor),
                    borderRadius: const BorderRadius.only(
                        topLeft: r, topRight: r, bottomLeft: r),
                  color: Theme.of(context).usertextColor,
                ),
                child: Text(
                  message.msg,
                  textAlign: TextAlign.center,
                )),

            const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),

            const SizedBox(width: 6),
          ]);
  }
}
