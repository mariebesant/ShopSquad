import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String responseToken;
  bool isLoading = false;

  Future onPressed() async {
    setState(() {
      isLoading = true;
    });

    String username = usernameController.text;
    String password = passwordController.text;

    Map<String, dynamic> requestBody = {
      "username": username,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/users/login'),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      responseToken = response.body;

      // ignore: avoid_print
      print('Erfolgreich angemeldet!');

      localStorage.setItem('accessBearer', responseToken);
      
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<dynamic>(
          builder: (context) => const MainPages(),
        ),
        (route) => false,
      );
    } else {
      // ignore: avoid_print
      print('Fehler bei der Anmeldung. Statuscode: ${response.statusCode}');
    }
      setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [ isLoading? CircularProgressIndicator(color: AppColors.green):
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Fertig',
              style: TextStyle(color: AppColors.white, fontSize: AppSizes.s1),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.s5,
              ),
              MyTextField(
                controller: usernameController,
                text: 'Benutzername',
                isPassword: false,
              ),
              MyTextField(
                controller: passwordController,
                text: 'Passwort',
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
