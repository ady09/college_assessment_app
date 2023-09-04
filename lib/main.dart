import 'package:college_assessment_app/src/features/authentication/controllers/auth_controller.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/assessment_screen.dart';

import 'package:college_assessment_app/src/features/authentication/screens/login_screen/login_screen.dart';

import 'package:college_assessment_app/src/utils/theme/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
    (value) {
      Get.put(AuthController());
    },
  );

  
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
   

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AssessmentScreen(),
    );
    
  }
}
//LoginScreen()
// FutureBuilder(
//         // Check if the user is authenticated
//         future: _auth.authStateChanges().first,
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Display a loading splash screen while checking the authentication status
//             return SplashScreen();
//           } else {
//             // If the user is authenticated, navigate to the home screen
//             if (snapshot.hasData && snapshot.data != null) {
//               return HomeScreen();
//             }
//             // If the user is not authenticated, navigate to the login screen
//             else {
//               return LoginScreen();
//             }
//           }
//         },
//       ),