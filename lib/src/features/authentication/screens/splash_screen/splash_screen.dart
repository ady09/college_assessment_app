import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/splash_screen_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);


  final splashScreenController = Get.put(SplashScreenController());
  
  @override
  Widget build(BuildContext context) {
    splashScreenController.startAnimation();

    print("splash screen generated");

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
                left: 0,
                right: 0,
                top: splashScreenController.animate.value ? 0 : -300,
                duration: const Duration(milliseconds: 1600),
                child: const Image(
                  image: AssetImage(eclipse),
                )),
          ),
          const Positioned(
              top: 60,
              right: 0,
              left: 0,
              child: Center(
                  child: Image(
                image: AssetImage(logo),
              ))),
          Obx(
            () => AnimatedPositioned(
              bottom: splashScreenController.animate.value ? 200 : 0,
              right: 0,
              left: 0,
              duration: const Duration(milliseconds: 1600),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashScreenController.animate.value ? 1 : 0,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      splash1,
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Text(splash2,
                        style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
