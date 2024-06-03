import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shopsquad/pages/homepage.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:shopsquad/widgets/toggle_payment.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPaypal = false;
  String paypalName = "";

  void _onPaymentChange(bool isPaypalSelected, String newPaypalName) {
    setState(() {
      isPaypal = isPaypalSelected;
      paypalName = newPaypalName;
    });
  }

  Future<void> onPressed() async {
    String username = usernameController.text;
    String password = passwordController.text;

    Map<String, dynamic> requestBody = {
      "username": username,
      "password": password,
      "isPaypal": isPaypal,
      "paypalName": paypalName
    };

    final response = await http.post(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/users/signin'),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
        localStorage.setItem('accessBearer',  response.body);

      Navigator.of(context).push(MaterialPageRoute<dynamic>(
        builder: (context) => const Homepage(),
      ));
    } else {
      print('Fehler bei der Anmeldung. Statuscode: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
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
              const SizedBox(height: AppSizes.s5),
              MyTextField(
                  controller: usernameController,
                  text: 'Benutzername',
                  isPassword: false),
              MyTextField(
                  controller: passwordController,
                  text: 'Passwort',
                  isPassword: true),
              TogglePayment(onPaymentChange: _onPaymentChange),
            ],
          ),
        ),
      ),
    );
  }
}
