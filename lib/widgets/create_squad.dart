import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:shopsquad/services/squad_service.dart';

class CreateSquad extends StatefulWidget {
  const CreateSquad(
      {super.key, required this.onPressed, required this.onGroupCreated});

  final VoidCallback onPressed;
  final VoidCallback onGroupCreated;

  @override
  State<CreateSquad> createState() => _CreateSquadState();
}

class _CreateSquadState extends State<CreateSquad> {
  TextEditingController groupnameController = TextEditingController();
  TextEditingController personController = TextEditingController();
  bool isLoading = false;

  static const IconData backIcon =
      IconData(0xf570, fontFamily: 'MaterialIcons', matchTextDirection: true);

  List<String> groupMembers = [];

  static const IconData addIcon = IconData(0xf52c, fontFamily: 'MaterialIcons');
  static const IconData removeIcon =
      IconData(0xf00eb, fontFamily: 'MaterialIcons');

  final SquadService groupService = SquadService();

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

  Future<void> newGroup(String groupname) async {
    setState(() {
      isLoading = true;
    });

    final response = await groupService.createSquad(groupname);

    if (response != null && response.statusCode == 200) { 
      widget.onGroupCreated();
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response?.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fehler'),
            content: Text(
                'Request failed with status: ${response?.statusCode}\nResponse: ${response?.body}'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenGray,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            backIcon,
            color: AppColors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (!isLoading) {
                newGroup(groupnameController.text);
              }
            },
            child: isLoading
                ? CircularProgressIndicator(color: AppColors.green)
                : Text(
                    'Fertig',
                    style: TextStyle(
                        color: AppColors.green, fontSize: AppSizes.s1),
                  ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.greenGray),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1),
              child: MyTextField(
                controller: groupnameController,
                text: 'Gruppenname',
                isPassword: false,
              ),
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
      ),
    );
  }
}
