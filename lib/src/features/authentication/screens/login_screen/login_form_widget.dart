import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.height,
    required this.emailController,
    required this.passwordController,
  });

  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailController,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              filled: true,
              hintText: email,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Image(image: AssetImage(profile)),
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(36))),
        ),
        SizedBox(height: height * 0.02),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: passwordController,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              filled: true,
              hintText: password,
              prefixIcon: IconButton(
                alignment: Alignment.centerLeft,
                onPressed: () {},
                icon: const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 3, left: 3, right: 3),
                    child: Image(image: AssetImage(passwordIcon)),
                  ),
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(36))),
        ),
      ],
    ));
  }
}
