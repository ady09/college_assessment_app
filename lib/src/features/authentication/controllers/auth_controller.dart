
import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:college_assessment_app/src/features/authentication/models/user.dart'
    as model;

import 'package:college_assessment_app/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../screens/home_screen/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SplashScreen());
    } else {
      print("next screen");
      Get.offAll(() => HomeScreen());
    }
  }

  void registerUser(String username, String email, String password) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user =
            model.User(name: username, email: email, uid: cred.user!.uid);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Something Went Wrong!", "Please Enter All The Details!");
      }
    } catch (e) {
      Get.snackbar("Please Check The Entered Details", "Something Went Wrong");
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print("success");
        Get.to(HomeScreen());
      } else {
        Get.snackbar("Something Went Wrong!", "Please Enter All The Details!");
      }
    } catch (e) {
      Get.snackbar("Please Check The Entered Details", "Something Went Wrong");
    }
  }
}
