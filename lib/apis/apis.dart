import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:translator_plus/translator_plus.dart';

import '../helper/global.dart';

class APIs {
  //get answer from chat gpt
  // static Future<String> getAnswer(String question) async {
  //   try {
  //     //
  //     final res =
  //         await post(Uri.parse('https://api.openai.com/v1/chat/completions'),
  //
  //             //headers
  //             headers: {
  //               HttpHeaders.contentTypeHeader: 'application/json',
  //               HttpHeaders.authorizationHeader: 'Bearer $apiKey'
  //             },
  //
  //             //body
  //             body: jsonEncode({
  //               "model": "gpt-3.5-turbo",
  //               "max_tokens": 2000,
  //               "temperature": 0,
  //               "messages": [
  //                 {"role": "user", "content": question},
  //               ]
  //             }));
  //
  //     final data = jsonDecode(res.body);
  //
  //     log('res: $data');
  //     return data['choices'][0]['message']['content'];
  //   } catch (e) {
  //     log('getAnswerE: $e');
  //     return 'Something went wrong (Try again in sometime)';
  //   }
  // }
  //get answer from our chatbot
  static Future<String> chatbot(String question) async {
    try {
      final res = await post(
          Uri.parse('https://project-iva.onrender.com/chat'),
          // Uri.parse('https://192.168.0.108:5000/chat'),
          body: {
            "content": question,
          }
      );

      if (res.body.isNotEmpty) {
        // final data = jsonDecode(res.body);
        final data = res.body;

        log('res: $data');
        return data;
      } else {
        log('Empty response body');
        return 'Server returned an empty response';
      }
    } catch (e, s) {
      if (e is FormatException) {
        log('Invalid JSON: $e');
      } else {
        log('getAnswerE: $e');
      }
      log('Stack trace: $s');
      return 'Something went wrong in the server (Try again in sometime)';
    }
  }

  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      final res =
          await get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      final data = jsonDecode(res.body);

      //
      return List.from(data['images']).map((e) => e['src'].toString()).toList();
    } catch (e) {
      log('searchAiImagesE: $e');
      return [];
    }
  }

  static Future<String> googleTranslate(
      {required String from, required String to, required String text}) async {
    try {
      final res = await GoogleTranslator().translate(text, from: from, to: to);

      return res.text;
    } catch (e) {
      log('googleTranslateE: $e ');
      return 'Something went wrong!';
    }
  }
}
