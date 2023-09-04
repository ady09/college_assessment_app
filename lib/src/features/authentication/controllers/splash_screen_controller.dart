
import 'package:college_assessment_app/src/features/authentication/screens/login_screen/login_screen.dart';


import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';



class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  RxBool animate = false.obs;


  

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    
      Get.to(LoginScreen());
   
  }
}
