import 'package:testiva/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../helper/global.dart';
import '../../widget/message_card.dart';
import '../../screen/feature/speech_to_text.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();
  SpeechRecognizer _speech = SpeechRecognizer();
  // String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text('Chat with IVA'),
      ),

      //send message field & btn
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          //text input field
          Expanded(
              child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.center,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    isDense: true,
                    hintText: 'Ask me anything you want...',
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              )),

          //for adding some space
          const SizedBox(width: 8),
          //microphone button
          Visibility(

              child: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).buttonColor,
                child: IconButton(
                  onPressed: () async {
                    if (_speech.isListening) {
                      _speech.stopListening();
                    } else {
                      _speech.startListening();
                      // _c.textC.text = _text;
                    }
                  },
                  icon: Icon(_speech.isListening ? Icons.stop_rounded : Icons.mic_rounded,
                      color: Colors.white, size: 28),
                ),
              )
          ),

          const SizedBox(width: 8),
          //send button
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: _c.askQuestion,
              icon: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 28),
            ),
          ),
        // stop button
        //   Obx(() => Visibility(
        //   // visible: _c.isOutputActive.value,
        //   child: CircleAvatar(
        //     radius: 24,
        //     backgroundColor: Theme.of(context).buttonColor,
        //     child: IconButton(
        //         onPressed: _c.stopOutput,
        //         icon: const Icon(Icons.stop_rounded,
        //           color: Colors.white, size: 28),
        //          ),
        //        ),
        //      )
        //    ),
        ]),
      ),

      //body
      body: Obx(
            () => ListView(
          physics: const BouncingScrollPhysics(),
          controller: _c.scrollC,
          padding:
          EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
          children: _c.list.map((e) => MessageCard(message: e)).toList(),
        ),
      ),
    );
  }
}