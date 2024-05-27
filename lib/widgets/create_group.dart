import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key, required this.onPressed, required this.onGroupCreated});

  final VoidCallback onPressed;
  final VoidCallback onGroupCreated;  

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupnameController = TextEditingController();
  TextEditingController personController = TextEditingController();
  bool isLoading = false;  // To track loading state

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

  Future<void> newGroup(String groupname) async {
    setState(() {
      isLoading = true;  // Start loading
    });

    String? accessToken = localStorage.getItem('accessBearer');

    if (accessToken == null) {
      print('Access token not found');
      setState(() {
        isLoading = false;  // Stop loading if there's an error
      });
      return;
    }
    accessToken = accessToken.substring(1, accessToken.length - 1);

    String url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads';
    Map<String, dynamic> body = {"squadName": groupname};

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Request successful');
      print('Response body: ${response.body}');
      widget.onGroupCreated();  
      widget.onPressed();
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    setState(() {
      isLoading = false;  // Stop loading once the request is complete
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
