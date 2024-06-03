import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/create_order.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/image_bill.dart';
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
  List<Map<String, dynamic>> body = [];
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
        listCardInfo = responseList.map<Map<String, dynamic>>((item) {
          return {
            ...item,
            'isChecked': false, // Initial value for isChecked
          };
        }).toList();
      });
    } else {
      // ignore: avoid_print
      print('Failed to fetch orders');
    }
    print(listCardInfo.length);
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

  Future<void> completeShopping(String base64Image) async {
    final response = await listOrderService.completeOrder(body, base64Image);

    if (response != null && response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPages()),
        (route) => false,
      );
    } else {
      print('Failed to complete orders');
    }
  }

  void _updateCheckedStatus(int index, bool? isChecked) {
    setState(() {
      listCardInfo[index]['isChecked'] = isChecked;
      listCardInfo.sort((a, b) => a['isChecked'] == true ? 1 : -1);

      body = listCardInfo.where((item) => item['isChecked'] == true).toList();
    });
  }

  void openImageBillAndCompleteShopping() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageBill(
          onImageConverted: (base64Image) {
            completeShopping(base64Image);
          },
        ),
      ),
    );
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
              totalTasks != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s1, horizontal: AppSizes.s1_25),
                      child: MyProgressIndicator(
                        totalTasks: totalTasks,
                        completedTasks: completedTasks,
                      ),
                    )
                  : const SizedBox(
                      height: AppSizes.s0_125,
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: listCardInfo.length,
                  itemBuilder: (context, index) {
                    final info = listCardInfo[index];
                    return ToDoCard(
                      isSortByPerson: false,
                      subtitle: (info['product']['price']).toString(),
                      title: (info['product']['name']).toString(),
                      trailing: info['quantity'],
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
                seconButtonPressed: openImageBillAndCompleteShopping,
              )
            ],
          );
  }
}
