import 'package:college_assessment_app/src/constants/image_strings.dart';
import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:college_assessment_app/src/features/authentication/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: double.infinity,
                      height: height * 0.18,
                      child: const Image(
                        image: AssetImage(loginDesign),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.08,
                    right: 10,
                    child: const SizedBox(
                        width: 100,
                        height: 80,
                        child: Image(image: AssetImage(logo))),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.084,
              ),
              Text(tLogin,
                  style: GoogleFonts.alegreya(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40))),
              SizedBox(
                height: height * 0.034,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoginForm(
                      height: height,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    SizedBox(
                      height: height * 0.054,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () => authController.loginUser(_emailController.text, _passwordController.text),
                            child: Text(
                              login.toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(RegisterScreen());
                              },
                              child: Text(
                                tSignup.toUpperCase(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
