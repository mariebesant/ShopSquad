import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/create_list.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/list_card.dart'; 

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> listItems = [];
  late String squadID;
  final SquadService groupService = SquadService();
  final ListOrderService listOrderService = ListOrderService();

  bool isLoading = false;

  Future<void> listCardInfo() async {
    setState(() {
      isLoading = true;
    });

    final response = await listOrderService.listCardInfo();
    final currentSquad = await groupService.currentSquad();

    if (response != null && response.statusCode == 200) {
      final responseList = json.decode(response.body);
      final responseData = json.decode(currentSquad!.body);

      setState(() {
        listItems = responseList; 
        squadID = responseData['id'];
      });
    } else {
      // ignore: avoid_print
      print('Failed to fetch list info');
    }

    setState(() {
      isLoading = false;
    });
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
  // Sorting the list by 'isFinished' status
  listItems.sort((a, b) => (a['isFinished'] ? 1 : 0) - (b['isFinished'] ? 1 : 0));

  return isLoading
      ? CircularProgressIndicator(color: AppColors.green)
      : Column(
          children: [
            Expanded(
              child: ListView(
                children: listItems.map((item) {
                  final String title = item['orderGroupName'].toString();
                  return ListCard(
                    imageUrl: item['image'],
                    isActive: !item['isFinished'],
                    title: title,
                    backgroundColor: AppColors.accentGray,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ToDoPage(
                            title: title,
                            squadListResponse: item,
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      // Delete logic here
                    },
                    onReceipt: () {
                      // Receipt logic here
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
