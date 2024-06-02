import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/create_order.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';
import 'package:shopsquad/widgets/to_do_card.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key, required this.squadListResponse});

  final Response squadListResponse; // Änderung des Typs

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Map<String, dynamic>> listCardInfo = [];
  final SquadService squadService = SquadService();
  final ListOrderService listOrderService = ListOrderService();
  String? orderGroupID;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    orderCardInfo();
  }

  Future<void> orderCardInfo() async {
    setState(() {
      isLoading = true;
    });

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
            'subtitle': item['product']['price'],
            'title': item['product']['name'],
            'trailing': item['quantity'],
            'isChecked': false, // Initial value for isChecked
          };
        }).toList();
      });
    } else {
      // ignore: avoid_print
      print('Failed to fetch orders');
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
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

  void _updateCheckedStatus(int index, bool? isChecked) {
    setState(() {
      listCardInfo[index]['isChecked'] = isChecked;
      listCardInfo.sort((a, b) => a['isChecked'] == true ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalTasks = listCardInfo.length;
    int completedTasks =
        listCardInfo.where((info) => info['isChecked'] == true).length;

    return isLoading
        ? CircularProgressIndicator(color: AppColors.green)
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.s1, horizontal: AppSizes.s1_25),
                child: MyProgressIndicator(
                  totalTasks: totalTasks,
                  completedTasks: completedTasks,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listCardInfo.length,
                  itemBuilder: (context, index) {
                    final info = listCardInfo[index];
                    return ToDoCard(
                      isSortByPerson: false,
                      subtitle: info['subtitle'],
                      title: info['title'],
                      trailing: info['trailing'],
                      isChecked: info['isChecked'],
                      onChanged: (bool? value) {
                        _updateCheckedStatus(index, value);
                      },
                    );
                  },
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
