import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/create_list.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/list_card.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  static const IconData moneyIcon =
      IconData(0xf1dd, fontFamily: 'MaterialIcons');

  List<String> listNames = [];
  late String squadID;
  final SquadService groupService = SquadService();

  Future<void> listCardInfo() async {
    final squadList = await groupService.listCardInfo();
    final currentSquad = await groupService.currentSquad();

    if (squadList != null) {
      Map<String, dynamic> responseData = json.decode(currentSquad!.body);
      setState(() {
        listNames = squadList;
        squadID = responseData['id'];
      });
    } else {
      print('Failed to fetch list info');
    }
  }

  void addList() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: CreateList(
          onPressed: () {
            Navigator.pop(context);
            listCardInfo();
          },
          onListCreated: listCardInfo,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: listNames.map((info) {
              return ListCard(
                subtitle:
                    const MyProgressIndicator(totalTasks: 5, completedTasks: 3),
                title: info, 
                trailing: Icon(
                  moneyIcon,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.accentGray,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ToDoPage(),
                    ),
                  );
                }, // onTap Funktion hier definiert
              );
            }).toList(),
          ),
        ),
        FooterButtons(onPressedAdd: addList)
      ],
    );
  }
}
