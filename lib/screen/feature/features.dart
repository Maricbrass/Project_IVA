import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:alarm/alarm.dart';
import 'package:testiva/controller/chat_controller.dart';
import 'package:testiva/screen/feature/time.dart';
import 'package:torch_light/torch_light.dart';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'text_to_speech.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class operation extends features
{
  final t = timeState();
  TextToSpeech tts = new TextToSpeech();
   Future<String> operations(str, n)
   async {
      if(str.contains('#SetAlarm'))
      {
        var re = t.timestate_alarm(n);
        return re;
      }
      else if(str.contains('#SetTimer'))
      {
        // tts.speak('How many minutes would you like to set the timer for?');
        // String? min = stdin.readLineSync();
        // setTimer(min as int);
        var re = t.timestate_timer(n);
        return re;
      }
      else if(str.contains('#Date'))
      {
       var d = date();
       List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        return 'Today is ${weekdays[d.weekday - 1]} - ${d.day}/${d.month}/${d.year}';
      }
      else if(str.contains('#Day'))
      {
        var d = date();
        List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        return 'Today is ${weekdays[d.weekday - 1]}';
      }
      // else if(str.contains('#OpenApp'))
      // {
      //   openApp('com.whatsapp');
      //   return 'Whatsapp opened';
      // }
      else if(str.contains('#CloseApp'))
      {
        closeApp();
        return 'App closed';
      }
      else if(str.contains('#OpenUrl'))
      {
        final Uri url = Uri.parse('www.google.com');
        openUrl(url.toString());
        return 'Opening Google';
      }
      else if(str.contains('#OpenContact'))
      {
        openContact('1234567890');
        return 'Calling 1234567890';
      }
      else if(str.contains('#OpenMap'))
      {
        openMap('28.7041', '77.1025');
        return 'Opening Map';
      }
      else if(str.contains('#OpenSetting'))
      {
        openSetting();
        return 'Opening Settings';
      }
      else if(str.contains('#OpenWifi'))
      {
        openWifi();
        return 'Opening Wifi';
      }
      else if(str.contains('#OpenBluetooth'))
      {
        openBluetooth();
        return 'Opening Bluetooth';
      }
      else if(str.contains('#OpenFlashlight'))
      {
        turnOnFlashlight();
        return 'Flashlight turned on';
      }
      else if(str.contains('#CloseFlashlight'))
      {
        turnOffFlashlight();
        return 'Flashlight turned off';
      }
      else if(str.contains('#OpenCamera'))
      {
        openCamera();
        return 'Opening Camera';
      }
      else if(str.contains('#OpenGallery'))
      {
        openGallery();
        return 'Opening Gallery';
      }
      else if(str.contains('#OpenMusic'))
      {
        openMusic();
        return 'Opening Music';
      }
      else if(str.contains('#OpenVideo'))
      {
        openVideo();
        return 'Opening Video';
      }
      else if(str.contains('#OpenYoutube'))
      {
        openYoutube();
        return 'Opening Youtube';
      }
      else if(str.contains('#OpenFacebook'))
      {
        openFacebook();
        return 'Opening Facebook';
      }
      else if(str.contains('#OpenInstagram'))
      {
        openInstagram();
        return 'Opening Instagram';
      }
      else if(str.contains('#OpenTwitter'))
      {
        openTwitter();
        return 'Opening Twitter';
      }
      // else if(str.contains('#OpenAlarm'))
      // {
      //   openAlarm();
      //   return 'Opening Alarm';
      // }
      else if(str.contains('#OpenCalendar'))
      {
        openCalendar();
        return 'Opening Calendar';
      }
      else if(str.contains('#OpenClock'))
      {
        openClock();
        return 'Opening Clock';
      }
      else if(str.contains('#OpenContacts'))
      {
        openContacts();
        return 'Opening Contacts';
      }
      else if(str.contains('#OpenDialer'))
      {
        openDialer();
        return 'Opening Dialer';
      }
      else if(str.contains('#OpenEmail'))
      {
        openEmail();
        return 'Opening Email';
      }
      else if(str.contains('#OpenFiles'))
      {
        openFiles();
        return 'Opening Files';
      }
      else if(str.contains('#OpenGmail'))
      {
        openGmail();
        return 'Opening Gmail';
      }
      else if(str.contains('#OpenMaps'))
      {
        openMaps();
        return 'Opening Maps';
      }
      else if(str.contains('#ShowAlarm'))
      {
        showAlarm();
        return 'Showing Alarms';
      }
      else if(str.contains('#ShowTimer'))
      {
        showTimer();
        return 'Showing Timers';
      }
      else if(str.contains('#OpenApp')| n.contains('open'))
      {
        String a = await getPackages(n);
        openApp(a);
        return a;
      }
      return str;
   }
}

class features
{
  int hrtomin(hr,min)
  {
    int time = hr*60 + min;
    // print(time);
    return time;
  }
  void setAlarm(int hour, int minute) {
    FlutterAlarmClock.createAlarm(hour: hour, minutes: minute);
  }

  void showAlarm() {
    FlutterAlarmClock.showAlarms();
  }

  void setTimer(int length) {
    FlutterAlarmClock.createTimer(length: length);
  }

  void showTimer() {
    FlutterAlarmClock.showTimers();
  }

  DateTime date() {
    DateTime now = DateTime.now();
    return now;
  }

// void displaynotification() {
//   displayNotification();
// }
  Future<void> turnOnFlashlight() async {
    // Check if the device has a torch
    if (await TorchLight.isTorchAvailable()) {
      // Enable the torch
      await TorchLight.enableTorch();
      print('Flashlight turned on!');
    } else {
      print('This device does not have a torch');
    }
  }

  Future<void> turnOffFlashlight() async {
    // Check if the torch is already on
    if (await TorchLight.isTorchAvailable()) {
      // Disable the torch
      await TorchLight.disableTorch();
      print('Flashlight turned off!');
    } else {
      print('The flashlight is already off');
    }
  }

  Future<void> openApp(String packageName) async {
    if (await LaunchApp.isAppInstalled(androidPackageName: packageName)) {
      // App is installed, open it directly
      await LaunchApp.openApp(androidPackageName: packageName);
    } else {
      // App is not installed, open the Play Store to download it
      await LaunchApp.openApp(androidPackageName: packageName, openStore: true);
    }
    // final AndroidIntent intent = AndroidIntent(
    //   action: 'android.intent.action.VIEW',
    //   category: 'android.intent.category.DEFAULT',
    //   package: packageName,
    // );
    // intent.launch();
    //   final AndroidIntent intent = AndroidIntent(
    //     action: 'android.intent.action.VIEW',
    //     category: 'android.intent.category.DEFAULT',
    //     data: 'package:$packageName',
    //   );
    //   await intent.launch();

  }

  void closeApp() {
    SystemNavigator.pop();
  }

  void openUrl(String url) async {
    if (1 == 1) {
      Uri u = Uri.parse("https://"+url);
      await launchUrl(u);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openContact(String contactNumber) async {
    String telScheme = 'tel:$contactNumber';

    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Could not launch $telScheme';
    }
  }

  void openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    print('URL: $googleUrl');

    bool canLaunchUrl = await canLaunch(googleUrl);
    print('Can launch URL: $canLaunchUrl');

    if (canLaunchUrl) {
      bool launched = await launch(googleUrl);
      print('Launched: $launched');
    } else {
      throw 'Could not open the map for $latitude,$longitude';
    }
  }

  void openSetting() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.settings',
    );
    intent.launch();
  }

  void openWifi() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.settings.WIFI_SETTINGS',
    );
    intent.launch();
  }

  void openBluetooth() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.settings.BLUETOOTH_SETTINGS',
    );
    intent.launch();
  }

  Future<void> openCamera() async {
    const url = 'android.media.action.IMAGE_CAPTURE';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
    // final AndroidIntent intent = AndroidIntent(
    //   // action: 'android.media.action.IMAGE_CAPTURE',
    //   action: 'com.android.camera',
    //   //  action: "MediaStore.ACTION_IMAGE_CAPTURE"
    // );
    // intent.launch();
  }

  void openGallery() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.LAUNCHER',
      package: 'com.google.android.apps.photos',
    );
    intent.launch();
  }

  void openMusic() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.music',
    );
    intent.launch();
  }

  void openVideo() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.video',
    );
    intent.launch();
  }

  Future<void> openYoutube() async {
    if (!await launchUrl(Uri.parse("https://www.youtube.com/"),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
    // await LaunchApp.openApp(
    //   androidPackageName: 'com.google.android.youtube',
    //   openStore: false,
    //   iosUrlScheme: 'youtube://',
    // );
  }

  Future<void> openFacebook() async {
    if (!await launchUrl(Uri.parse("https://www.facebook.com/"),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
    // await LaunchApp.openApp(
    //   androidPackageName: 'com.facebook.katana',
    //   openStore: true,
    //   iosUrlScheme: 'fb://',
    // );
  }

  Future<void> openInstagram() async {
    if (!await launchUrl(Uri.parse("https://www.instagram.com/"),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
    // await LaunchApp.openApp(
    //   androidPackageName: 'com.instagram.android',
    //   openStore: true,
    //   iosUrlScheme: 'instagram://',
    // );
  }

  Future<void> openTwitter() async {
    Uri u = Uri.parse("https://www.twitter.com");
    await launchUrl(u);
    // final AndroidIntent intent = AndroidIntent(
    //   action: 'action_main',
    //   package: 'com.twitter.android',
    // );
    // intent.launch();
  }

  void openAlarm() {
    showAlarm();
  }

  void openCalendar() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.calendar',
    );
    intent.launch();
  }

  void openClock() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.clock',
    );
    intent.launch();
  }

  void openContacts() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.contacts',
    );
    intent.launch();
  }

  void openDialer() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.dialer',
    );
    intent.launch();
  }

  void openEmail() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.LAUNCHER',
      package: 'com.android.email',
    );
    intent.launch();
  }

  void openFiles() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.files',
    );
    intent.launch();
  }

  void openGmail() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.google.android.gm',
    );
    intent.launch();
  }

  void openMaps() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.google.android.apps.maps',
    );
    intent.launch();
  }
  Future<String> getPackages(n) async {
    final words = n.split(' ');
    if (words.length < 2) {
      throw Exception("Invalid input");
    }
    var app = words[1];
    Uri u = Uri.parse("https://play.google.com/store/search?q=$app");
    print(u);
    final res = await getPlayStoreFirstResult(u.toString());
    print(res);
    if (res == null) {
      throw Exception("Could not fetch Play Store result");
    }
    var pkg = extractAppIdFromUrl(res);
    print(pkg);
    return pkg;
  }

  Future<String?> getPlayStoreFirstResult(String url) async {
    // if (url != "https://play.google.com/store/search?q=spotify") {
    //   return null; // Handle only the specific search URL
    // }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        // print(document.outerHtml);

        // This targets a specific element class based on Play Store's current layout.
        // You may need to adjust this based on future layout changes.
        final firstResult = document.querySelector('.ipRz4');
        // print(firstResult);
        if (firstResult != null) {
          final link = firstResult.querySelector('a[href]');
        // print(link) ;
          if (link != null && link.attributes['href'] != null) {
            return "https://play.google.com" + link.attributes['href']!;
          }
        }
      } else {
        print("Failed to fetch response: ${response.statusCode}");
      }
    } catch (error) {
      print("Error getting Play Store result: $error");
    }

    return null;
  }
  String extractAppIdFromUrl(String url) {
    final uri = Uri.parse(url);
    final parts = uri.queryParametersAll['id'];

    if (parts!.isEmpty) {
      return ""; // Handle case where 'id' parameter is missing
    }

    // Assuming there's only one value for 'id' (common case)
    return parts.first.toString();
  }


}