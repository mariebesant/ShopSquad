import 'package:flutter/material.dart';
import 'package:shopsquad/pages/add_group.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/join_squad.dart';
import 'package:shopsquad/widgets/my_button.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                text: 'Neue Gruppe',
                color: AppColors.white,
                backgroundColor: AppColors.accentGray,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => const AddGroup(),
                    ),
                  );
                },
              ),
              MyButton(
                text: 'Gruppe beitreten',
                backgroundColor: AppColors.accentGray,
                color: AppColors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog.fullscreen(
                      child: JoinSquad(
                        navigate: 'Homepage',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        onGroupCreated: () {
                          Navigator.pop(context);
                        },
                      ),
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
