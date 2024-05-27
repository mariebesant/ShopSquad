import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class CreateList extends StatefulWidget {
  const CreateList({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  TextEditingController listnameController = TextEditingController();
  TextEditingController personController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.greenGray),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    'Fertig',
                    style: TextStyle(
                        color: AppColors.green, fontSize: AppSizes.s1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1),
                child: MyTextField(
                    controller: listnameController,
                    text: 'Listenname',
                    isPassword: false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
