import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:testiva/controller/chat_controller.dart';

import 'chatbot_feature.dart';

class WakeWord extends StatefulWidget {
  @override
  _WakeWordState createState() => _WakeWordState();
}

class _WakeWordState extends State<WakeWord> {
  // final _c = ChatController();
  final cf = ChatBotFeatureState();
  stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        if (result.recognizedWords.contains('Hey IVA')) {
          _speech.stop();
          wakeword();
        }
      },
      listenFor: Duration(hours: 24), // Listen indefinitely
    );
  }
  void wakeword() async {
    // bool isServiceAvailable =
    // await SpeechToTextGoogleDialog.getInstance()
    //     .showGoogleDialog(
    //   onTextReceived: (data) {
    //     String result;
    //     setState(() {
    //       result = data.toString();
    //       _c.textC.text = result;
    //       _c.askQuestion();
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }



}