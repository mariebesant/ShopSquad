import 'package:flutter/material.dart';
import 'package:shopsquad/pages/homepage.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});
// onPressed: (context) => Navigator.of(context).push(
//                   MaterialPageRoute<dynamic>(
//                     builder: (context) => const Login(),
//                   ),
//                 ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          TextButton(
            onPressed: ()  => Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const Homepage(),
                  ),
                ),
            child: Text(
              'Fertig',
              style: TextStyle(color: AppColors.white, fontSize: AppSizes.s1),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.s1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppSizes.s5,
              ),
              MyTextField(
                text: 'Benutzername',
                isPassword: false,
              ),
              MyTextField(
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
