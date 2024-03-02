import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:alarm/alarm.dart';
import 'package:torch_light/torch_light.dart';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'text_to_speech.dart';

class operation extends features
{
  TextToSpeech tts = new TextToSpeech();
   Future<String> operations(str)
   async {
      if(str.contains('#SetAlarm'))
      {
        setAlarm(2,30);
        return 'Alarm set for 2:30';
      }
      else if(str.contains('#SetTimer'))
      {
        tts.speak('How many minutes would you like to set the timer for?');
        String? min = stdin.readLineSync();
        setTimer(min as int);
        return 'Timer set for $min minutes';
      }
      else if(str.contains('#date'))
      {
       var d = date();
        return 'Today is ${d.day}/${d.month}/${d.year}';
      }
      else if(str.contains('#OpenApp'))
      {
        openApp('com.whatsapp');
        return 'Whatsapp opened';
      }
      else if(str.contains('#CloseApp'))
      {
        closeApp();
        return 'App closed';
      }
      else if(str.contains('#OpenUrl'))
      {
        openUrl('https://www.google.com');
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
      else if(str.contains('#OpenAlarm'))
      {
        openAlarm();
        return 'Opening Alarm';
      }
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

  void openApp(String packageName) {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      package: packageName,
    );
    intent.launch();
  }

  void closeApp() {
    SystemNavigator.pop();
  }

  void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
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
      action: 'action_application_details_settings',
      package: 'com.android.settings',
    );
    intent.launch();
  }

  void openWifi() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      package: 'android.settings.WIFI_SETTINGS',
    );
    intent.launch();
  }

  void openBluetooth() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      package: 'android.settings.BLUETOOTH_SETTINGS',
    );
    intent.launch();
  }

  void openCamera() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.camera',
    );
    intent.launch();
  }

  void openGallery() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.gallery3d',
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

  void openYoutube() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.google.android.youtube',
    );
    intent.launch();
  }

  void openFacebook() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.facebook.katana',
    );
    intent.launch();
  }

  void openInstagram() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.instagram.android',
    );
    intent.launch();
  }

  void openTwitter() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.twitter.android',
    );
    intent.launch();
  }

  void openAlarm() {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_main',
      package: 'com.android.alarm',
    );
    intent.launch();
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
      action: 'action_main',
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
}