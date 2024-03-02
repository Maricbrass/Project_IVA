import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../controller/chat_controller.dart';

class SpeechRecognizer {
  final _c = ChatController();
  final SpeechToText _speech = SpeechToText();

  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  bool get isListening => _isListening;
  String get text => _text;

  Future<void> initSpeechState() async {
    final hasSpeech = await _speech.initialize(
      onStatus: (status) {
        print('status: $status');
      },
      onError: (error) {
        print('error: $error');
      },
    );

    if (hasSpeech) {
      print(hasSpeech);
      final localeNames = await _speech.locales();

      final systemLocale = await _speech.systemLocale();
    } else {
      print('The user has denied the use of speech recognition.');
    }
  }

  Future<void> startListening() async {
    if (!_speech.isAvailable) {
      await initSpeechState();
    }
    _isListening = true;
    _text = '';

    await _speech.listen(
      onResult: (result) {
        _text = result.recognizedWords;
        if (result.finalResult) {
          _isListening = false;
        }
        print(_text);
        _c.sttmsg(_text);
      },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
  }
}