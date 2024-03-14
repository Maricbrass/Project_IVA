import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
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
  State<ChatBotFeature> createState() => ChatBotFeatureState();
}

class ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();
  SpeechRecognizer _speech = SpeechRecognizer();
  bool vis = false;

  static const Color primaryColor = Color(0xFF630D69);
  static const Color c2 = Color(0xFF240753);
  static const Color secondaryColor = Colors.white;
  static const Color accentColor =
  Color(0xFF4CAF50); //#630d69 #240753 #2a053d  // Green

  @override
  Widget build(BuildContext context) {
    vis = _c.textC.text.isNotEmpty ? true : false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF612461),
        title: const Text('Chat with IVA',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: vis,
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _c.textC.clear();
                      _c.tts.stop();
                      setState(() {
                        vis = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.transparent),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.red)),
                    ),
                    icon: const Icon(Icons.clear_rounded,
                        color: Colors.red, size: 20),
                    label: const Text('Stop',
                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5,height: 1, decorationStyle: TextDecorationStyle.solid , decorationColor: Colors.red, decorationThickness: 2)),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _c.textC,
                      textAlign: TextAlign.center,
                      onTapOutside: (e) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        hintText: 'Ask me anything you want...',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                              color: primaryColor.withOpacity(0.5)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: mic,
                          icon: Icon(_speech.isListening
                              ? Icons.stop_rounded
                              : Icons.mic), // Replace with your icon
                          color: Colors.white,
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Visibility(
                  //     child: CircleAvatar(
                  //       radius: 24,
                  //       backgroundColor: Theme.of(context).buttonColor,
                  //       child: IconButton(
                  //         onPressed: mic,
                  //         icon: Icon(_speech.isListening
                  //             ? Icons.stop_rounded
                  //             : Icons.mic), // Replace with your icon
                  //         color: Colors.white,
                  //       ),
                  //     )),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).buttonColor,
                    child: IconButton(
                      onPressed: _c.askQuestion,
                      icon: const Icon(Icons.send_rounded,
                          color: Colors.white, size: 28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF612461), Color(0xFF010061)],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(1, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: double.infinity,
            height: 675,
            decoration: BoxDecoration(
              color: Theme.of(context).chatTextColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Obx(
                  () => ListView(
                physics: const BouncingScrollPhysics(),
                controller: _c.scrollC,
                padding:
                EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
                children: _c.list.map((e) {
                  bool isFromUser = true; // Define your isFromUser variable here
                  return MessageCard(
                    key: ValueKey(e),
                    message: e,
                    isFromUser: isFromUser,
                    backgroundColor:
                    isFromUser ? primaryColor : secondaryColor,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void mic() async {
    bool isServiceAvailable =
    await SpeechToTextGoogleDialog.getInstance().showGoogleDialog(
      onTextReceived: (data) {
        String result;
        setState(() {
          result = data.toString();
          _c.textC.text = result;
          _c.askQuestion();
        });
      },
    );
  }
}