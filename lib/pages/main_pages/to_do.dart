import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/widgets/create_order.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/to_do_card.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key, required this.squadListResponse});

  final Response squadListResponse; // Änderung des Typs

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Map<String, dynamic>> listCardInfo = [];
  bool _isLoading = true;
  final SquadService squadService = SquadService();
  final ListOrderService listOrderService = ListOrderService();
  String? orderGroupID;

  @override
  void initState() {
    super.initState();
    orderCardInfo();
  }

  Future<void> orderCardInfo() async {
    final response =
        await listOrderService.listOrders(widget.squadListResponse);

    Map<String, dynamic> responseMap =
        jsonDecode(widget.squadListResponse.body);
    orderGroupID = responseMap['id'];

    if (response != null && response.statusCode == 200) {
      List<dynamic> responseList = json.decode(response.body);
      setState(() {
        listCardInfo = responseList.map((item) {
          return {
            'isSortByPerson': item['isSortByPerson'],
            'isChecked': item['isChecked'],
            'subtitle': item['product']['price'],
            'title': item['product']['name'],
            'trailing': item['quantity'],
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

  void addGrocery() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: CreateOrder(
          orderGroupID: orderGroupID ?? '',
          onPressed: () {
            Navigator.pop(context);
            orderCardInfo();
          },
          onOrderCreated: orderCardInfo,
        ),
      ),
    );
  }

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
                    print(info);
                    return ToDoCard(
                      isSortByPerson: false,
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
