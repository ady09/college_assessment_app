import 'package:college_assessment_app/src/features/authentication/screens/register_screen/register_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class RegisterScreen extends StatelessWidget {
 RegisterScreen({super.key});

  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerNameController = TextEditingController();

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
                height: height * 0.054,
              ),
              Text(registerHeader,
                  style: GoogleFonts.alegreya(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30))),
              SizedBox(
                height: height * 0.034,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RegisterForm(height: height, registerEmailController: _registerEmailController, registerPasswordController: _registerPasswordController, registerNameController: _registerNameController),
                    SizedBox(
                      height: height * 0.054,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () => authController.registerUser(_registerNameController.text, _registerEmailController.text, _registerPasswordController.text),
                            child: Text(
                              done.toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
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
