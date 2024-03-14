import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';


class time extends StatefulWidget {
  const time({super.key});

  @override
  State<time> createState() => timeState();
}

class timeState extends State<time> {

  static const apiKey = "AIzaSyAffMuAHQH3b5XFA-FmStxACHhprEjgDvk";
  final _speech = SpeechToText();
  bool _isListening = false;

  Future<String> timestate_alarm(String n) async {
    String ala = 'Alarm set';
    ala =  await t(n) as String;
    print(ala) ;
    final hour = int.parse(ala.split(':')[0]);
    final minute = int.parse(ala.split(':')[1]);
    ala = setAlarm(hour, minute);
    return ala;
  }
  Future<String> timestate_timer(String n) async {
    String tim = 'Timer set';
    tim =  await t(n) as String;
    print(tim) ;

    final hour = int.parse(tim.split(':')[0]);
    var minute = int.parse(tim.split(':')[1]);
    minute = (hour * 60) + minute;
    print(minute);
    tim = setTimer(minute);
    return tim;
  }

  Future<String?> t(n) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final prompt = 'i will provide an Input just convert it in an 24 hour time format like "01:30" and here is the input $n';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);
    String? timeString = response.text;
    return timeString;
  }

  @override
  void initState() {
    super.initState();
    _speech.listen(
      onResult: (result) {
        timestate_alarm(result.recognizedWords);
        _speech.stop();
      },
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool hasSpeech = await _speech.initialize();
      if (hasSpeech) {
        _speech.listen();
      }
    } else {
      _speech.stop();
    }
    setState(() {
      _isListening = !_isListening;
    });
  }

  DateTime? parseAlarmTime(String spokenTime) {
    spokenTime = spokenTime.trim();

    final timeRegex = RegExp (
        r"(\s*(\d{1,2}:\d{1,2})\s*|(\d+ (o'clock|pm|am)?)|(\d+ (quarter|half) past \d+)|(\d+ (to|after) \d+))");

    final match = timeRegex.firstMatch(spokenTime);
    if (match == null) {
      print('Invalid format: $spokenTime');
      return null;
    }

    final timeString = match.group(1) ?? match.group(2) ?? match.group(4);
    final meridian = match.group(6) ?? match.group(8);
    var hour = int.tryParse(match.group(2) ?? match.group(4) ?? '') ?? -1;
    final minute = int.tryParse(match.group(3) ?? '') ?? 0;

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      print('Invalid time values: $hour:$minute');
      return null;
    }

    if (meridian != null && meridian.toLowerCase() == 'pm' && hour != 12) {
      hour = hour + 12;
    } else if (meridian != null && meridian.toLowerCase() == 'am' && hour == 12) {
      hour = 0;
    }

    try {
      return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    } on ArgumentError {
      print('Invalid date/time: $hour:$minute');
      return null;
    }
  }

  String setAlarm(h, m) {
    try {
      FlutterAlarmClock.createAlarm(
        hour: h,
        minutes: m,
      );
      // Show a success message or notification
    } on Exception catch (e) {
      // Handle errors (e.g., invalid time, permission issues)
      print('Error setting alarm: $e');
    }
    DateTime time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, h, m);
    return 'Alarm set for: ${time.hour}:${time.minute}';
  }

  String setTimer(duration) {
    FlutterAlarmClock.createTimer(length: duration);

    print('Starting timer for: $duration');
    return 'Timer set for: $duration seconds ';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}