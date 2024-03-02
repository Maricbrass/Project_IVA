 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testiva/screen/feature/features.dart';

import '../apis/apis.dart';
import '../helper/my_dialog.dart';
import '../model/message.dart';
import '../screen/feature/text_to_speech.dart';

 class ChatController extends GetxController {
   final textC = TextEditingController();
   final tts = TextToSpeech();
   final scrollC = ScrollController();
   final feature = features();
   operation operations = new operation();

   // final isOutputActive = false.obs;

   final list = <Message>[
     Message(msg: 'Hello, How can I help you?', msgType: MessageType.bot)
   ].obs;

   Future<void> askQuestion() async {
     // isOutputActive.value = true;
     if (textC.text.trim().isNotEmpty) {
       //user
       list.add(Message(msg: textC.text, msgType: MessageType.user));
       list.add(Message(msg: '', msgType: MessageType.bot));
       _scrollDown();

       final res = await APIs.chatbot(textC.text);
       // final res = await APIs.getAnswer(textC.text);
       final r = await operations.operations(res);
       tts.speak(r as String);

       //ai bot
       list.removeLast();
       list.add(Message(msg: r, msgType: MessageType.bot));
       _scrollDown();

       // tts.speak(res);
       //
       // //ai bot
       // list.removeLast();
       // list.add(Message(msg: res, msgType: MessageType.bot));
       // _scrollDown();

       textC.text = '';
     } else {
       MyDialog.info('Ask Something!');
     }
     // isOutputActive.value = false;
   }

   Future<void> sttmsg(String msg) async {
     // isOutputActive.value = true;
     if (msg.trim().isNotEmpty) {
       //user
       list.add(Message(msg: msg, msgType: MessageType.user));
       list.add(Message(msg: '', msgType: MessageType.bot));
       _scrollDown();
       update(); // Notify the UI about the new message

       final res = await APIs.chatbot(msg);
       // final res = await APIs.getAnswer(msg);
       // operation.operations(res);
       tts.speak(res);

       //ai bot
       list.removeLast();
       list.add(Message(msg: res, msgType: MessageType.bot));
       _scrollDown();
       update(); // Notify the UI about the bot's response
     } else {
       MyDialog.info('Ask Something!');
     }
     // isOutputActive.value = false;
   }

   //for moving to end message
   void _scrollDown() {
     if (scrollC.hasClients) {
       scrollC.animateTo(scrollC.position.maxScrollExtent,
           duration: const Duration(milliseconds: 500), curve: Curves.ease);
     }
   }

   // Future<void> stopOutput() async {
   //   tts.stop();
   //   isOutputActive.value = false;
   // }


 }
