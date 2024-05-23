import 'package:flutter/material.dart';
import 'package:shopsquad/pages/login.dart';
import 'package:shopsquad/pages/sign_in.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        toolbarHeight: 0.1,
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          width: AppSizes.s13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.s2),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: AppSizes.s5,
                ),
              ),
              MyButton(
                text: 'Login',
                color: AppColors.white,
                backgroundColor: AppColors.accentGray,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => Login(),
                    ),
                  );
                },
              ),
              MyButton(
                text: 'Registrieren',
                color: AppColors.white,
                backgroundColor: AppColors.accentGray,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppSizes.s5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
