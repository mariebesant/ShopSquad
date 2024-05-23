import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupnameController = TextEditingController();
  TextEditingController personController = TextEditingController();

  List<String> groupMembers = [];

  static const IconData addIcon = IconData(0xf52c, fontFamily: 'MaterialIcons');
  static const IconData removeIcon =
      IconData(0xf00eb, fontFamily: 'MaterialIcons');

  void addPerson() {
    String person = personController.text;
    if (person.isNotEmpty) {
      setState(() {
        groupMembers.add(person);
      });
      personController.clear();
    }
  }

  void removePerson(int index) {
    setState(() {
      groupMembers.removeAt(index);
    });
  }

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
                    controller: groupnameController,
                    text: 'Gruppenname',
                    isPassword: false),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.s1),
            child: MyTextField(
              controller: personController,
              text: 'Person hinzufügen',
              isPassword: false,
              suffix: IconButton(
                icon: Icon(
                  addIcon,
                  color: AppColors.green,
                ),
                onPressed: addPerson,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      removeIcon,
                      color: AppColors.warning,
                    ),
                    onPressed: () => removePerson(index),
                  ),
                  title: Text(
                    groupMembers[index],
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
