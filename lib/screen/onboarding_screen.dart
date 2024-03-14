import 'package:testiva/main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';
import '../helper/pref.dart';
import '../model/onboard.dart';
import '../widget/custom_btn.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final c = PageController();
  final un = TextEditingController();
  var unvis = true;

  @override
  Widget build(BuildContext context) {
    final list = [
      Onboard(
          title: 'Your Name',
          subtitle:
          'I can be your Best Friend & You can ask me anything & I will help you!',
          lottie: 'ai_hand_waving'),

      //onboarding 1
      Onboard(
          title: 'Ask me Anything',
          subtitle:
          'I can be your Best Friend & You can ask me anything & I will help you!',
          lottie: 'ai_ask_me'),

      //onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        lottie: 'ai_play',
        subtitle:
        'Just Imagine anything & let me know, I will create something wonderful for you!',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: c,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;

          return SingleChildScrollView(
          child:
            Row(
            // child: Column(
              children: <Widget>[
            // child:
              Expanded(
              flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:Column(
                    children: [
                      //lottie
                      Lottie.asset('assets/lottie/${list[ind].lottie}.json',
                          height: mq.height * .6, width: isLast ? mq.width * .7 : null),

                      //title
                      Text(
                        list[ind].title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .5),
                      ),

                      //for adding some space
                      SizedBox(height: mq.height * .015),

                      //subtitle
                      //subtitle
                      Visibility(
                        visible: ind != 0,
                        child: SizedBox(
                          width: mq.width * .7,
                          child: Text(
                            list[ind].subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13.5,
                                letterSpacing: .5,
                                color: Theme.of(context).lightTextColor),
                          ),
                        ),
                      ),

                      Visibility(
                          visible: ind == 0,
                          child: TextField(
                            controller: un,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                filled: true,
                                isDense: true,
                                hintText: 'Enter your name...',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50)))),
                          )
                      ),

                      const Spacer(),

                      //dots

                      Wrap(
                        spacing: 10,
                        children: List.generate(
                            list.length,
                                (i) => Container(
                              width: i == ind ? 15 : 10,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: i == ind ? Colors.purple : Colors.grey,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                            )),
                      ),

                      const Spacer(),

                      //button
                      CustomBtn(
                          onTap: () {
                            if (isLast) {
                              Pref.username = un.text; // Store the entered name
                              Get.off(() => const HomeScreen());
                            } else {
                              c.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.ease
                              );
                            }
                          },
                          text: isLast ? 'Finish' : 'Next'
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
              ],
            ),
          );
        },
      ),
    );
  }
}