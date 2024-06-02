import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/create_list.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/list_card.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  static const IconData menu = IconData(0xf8dc, fontFamily: 'MaterialIcons');

  List<dynamic> listItems = []; // Liste für die gesamte Antwort
  late String squadID;
  final SquadService groupService = SquadService();
  final ListOrderService listOrderService = ListOrderService();

  Future<void> listCardInfo() async {
    final response = await listOrderService.listCardInfo();
    final currentSquad = await groupService.currentSquad();

    if (response != null && response.statusCode == 200) {
      final responseList = json.decode(response.body);
      final responseData = json.decode(currentSquad!.body);

      setState(() {
        listItems = responseList; // Die gesamte Antwort speichern
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
            children: listItems.map((item) {
              final String title = item['orderGroupName'].toString();
              return ListCard(
                subtitle: const MyProgressIndicator(totalTasks: 5, completedTasks: 3),
                title: title,
                trailing: Icon(
                  menu,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.accentGray,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ToDoPage(
                        squadListResponse: item, // Das gesamte Element übergeben
                      ),
                    ),
                  );
                },
                onDelete: () {
                  // Lösch-Logik hier
                },
                onReceipt: () {
                  // Belege-Logik hier
                },
              );
            }).toList(),
          ),
        ),
        FooterButtons(onPressedAdd: addList)
      ],
    );
  }
}
