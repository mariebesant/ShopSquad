import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key, required this.onPressed, required this.onOrderCreated});

  final VoidCallback onPressed;
  final VoidCallback onOrderCreated;

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController orderController = TextEditingController();
  TextEditingController orderQuantityController = TextEditingController();
  final SquadService groupService = SquadService();
  final ListOrderService listOrderService = ListOrderService();

  bool isLoading = false;

  static const IconData backIcon =
      IconData(0xf570, fontFamily: 'MaterialIcons', matchTextDirection: true);

  Future<void> newGroup(String groupname) async {
    setState(() {
      isLoading = true;
    });

    final currentSquad = await groupService.currentSquad();
    Map<String, dynamic> responseData = json.decode(currentSquad!.body);
    String squadID = responseData['id'];

    final response = await listOrderService.createList(groupname, squadID);

    if (response != null && response.statusCode == 200) {
      print('Request successful');
      print('Response body: ${response.body}');
      widget.onOrderCreated();
      Navigator.of(context).pop();
    } else {
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
                newGroup(orderController.text);
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1),
          child: MyTextField(
              controller: orderQuantityController,
              text: 'Menge',
              isPassword: false),
        ),
      ),
    );
  }
}
