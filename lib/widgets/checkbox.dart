import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);


  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox( 
      shape: CircleBorder(),
      checkColor: AppColors.success, 
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return Colors.transparent;
        },
      ),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
