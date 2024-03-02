//import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:get/get.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //set delay splash screen
    Future.delayed(Duration(seconds: 4), () {
      Get.offNamed(Routes.HOME);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Al Quran Apps",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: Color(0xff9345F2),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Text(
                "Sesibuk itukah sampai lupa membaca Al Quran",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  //color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              height: 300,
              child: Lottie.asset("assets/lotties/animasi-quran.json"),
            ),
            SizedBox(
              height: 100,
            ),

            Text(
              "Made with ❤️ by Rengga Ferdiansa",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),

            // ElevatedButton(
            //   onPressed: () => Get.offAllNamed(Routes.HOME),
            //   child: Text(
            //     "Get Started",
            //     style: TextStyle(
            //         color: Get.isDarkMode ? appPurpleDark1 : appWhite),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       primary: Get.isDarkMode ? appWhite : appPurple,
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 50,
            //         vertical: 20,
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
