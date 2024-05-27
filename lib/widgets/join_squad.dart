import 'package:flutter/material.dart';
import 'package:shopsquad/pages/homepage.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:shopsquad/services/squad_service.dart';

class JoinSquad extends StatefulWidget {
  const JoinSquad(
      {super.key,
      required this.onPressed,
      required this.onGroupCreated,
      this.navigate});

  final VoidCallback onPressed;
  final VoidCallback onGroupCreated;
  final String? navigate;

  @override
  State<JoinSquad> createState() => _JoinSquadState();
}

class _JoinSquadState extends State<JoinSquad> {
  TextEditingController groupIDController = TextEditingController();
  bool isLoading = false;

  static const IconData backIcon =
      IconData(0xf570, fontFamily: 'MaterialIcons', matchTextDirection: true);

  final SquadService groupService = SquadService();

  Future<void> joinGroup(String id) async {
    setState(() {
      isLoading = true;
    });

    final response = await groupService.joinGroup(id);

    if (response != null && response.statusCode == 200) {
      print('Request successful');
      print('Response body: ${response.body}');
      widget.onGroupCreated();
    } else {
      print('Request failed with status: ${response?.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Fehler'),
            content: Text(
                'Request failed with status: ${response?.statusCode}\nResponse: ${response?.body}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
                joinGroup(groupIDController.text);
                widget.navigate == 'homepage'
                    ? Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(
                          builder: (context) => const MainPages(),
                        ),
                      )
                    : null;
              }
            },
            child: isLoading
                ? CircularProgressIndicator(color: AppColors.green)
                : Text(
                    'Beitreten',
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
                controller: groupIDController,
                text: 'Gruppen ID',
                isPassword: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
