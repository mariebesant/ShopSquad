import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/to_do_card.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key, required this.body});

  final Response body;

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Map<String, dynamic>> listCardInfo = [];
  bool _isLoading = true;
  final SquadService squadService = SquadService();
  final ListOrderService listOrderService = ListOrderService();

  @override
  void initState() {
    super.initState();
    fetchListOrders();
  }

  Future<void> fetchListOrders() async {
    final response = await listOrderService.listOrders(widget.body);
    if (response != null && response.statusCode == 200) {
      List<dynamic> responseList = json.decode(response.body);
      setState(() {
        listCardInfo = responseList.map((item) {
          return {
            'isSortByPerson': item['isSortByPerson'],
            'isChecked': item['isChecked'],
            'subtitle': item['subtitle'],
            'title': item['title'],
            'trailing': item['trailing'],
          };
        }).toList();
        _isLoading = false;
      });
    } else {
      print('Failed to fetch orders');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addGrocery() {}

  void completeShopping() {}

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: ListView(
                  children: listCardInfo.map((info) {
                    return ToDoCard(
                      isSortByPerson: info['isSortByPerson'],
                      isChecked: info['isChecked'],
                      subtitle: info['subtitle'],
                      title: info['title'],
                      trailing: info['trailing'],
                    );
                  }).toList(),
                ),
              ),
              FooterButtons(
                onPressedAdd: addGrocery,
                buttonText: 'EINKAUFEN',
                seconButtonPressed: completeShopping,
              )
            ],
          );
  }
}
