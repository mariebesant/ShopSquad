import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:shopsquad/services/list_order_service.dart';
import 'package:shopsquad/services/auth_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_numberfield.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder(
      {super.key,
      required this.onPressed,
      required this.onOrderCreated,
      required this.orderGroupID});

  final VoidCallback onPressed;
  final VoidCallback onOrderCreated;
  final String orderGroupID;

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController orderQuantityController = TextEditingController();
  TextEditingController orderUnitController = TextEditingController();
  final ListOrderService listOrderService = ListOrderService();
  final AuthService authService = AuthService();

  bool isLoading = false;
  List<Map<String, dynamic>> products = [];

  Map<String, dynamic>? selectedProduct;

  static const IconData backIcon =
      IconData(0xf570, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final productList = await listOrderService.getProducts();
    if (productList != null) {
      setState(() {
        products = productList;
      });
    } else {
      print('Failed to load products');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fehler'),
          content: Text(message),
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

  Future<void> createOrder() async {
    setState(() {
      isLoading = true;
    });

    final selectedProductId = selectedProduct?['id'];
    final quantity = int.tryParse(orderQuantityController.text) ?? 0;

    if (selectedProductId == null) {
      setState(() {
        isLoading = false;
      });
      _showAlert('Bitte wählen Sie ein Produkt aus.');
      return;
    }

    if (quantity <= 0) {
      setState(() {
        isLoading = false;
      });
      _showAlert('Bitte geben Sie eine gültige Menge ein.');
      return;
    }

    final body = json.encode({
      "orderGroupId": widget.orderGroupID,
      "product": selectedProduct,
      "quantity": quantity
    });

    final response = await listOrderService.createOrder(body);

    if (response != null && response.statusCode == 200) {
      widget.onOrderCreated();
      Navigator.of(context).pop();
    } else {
      print('Failed to create order');
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
                createOrder();
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
          child: Column(
            children: [
              const SizedBox(height: AppSizes.s1),
              DropdownSearch<Map<String, dynamic>>(
                items: products,
                itemAsString: (Map<String, dynamic> p) => p['product'],
                onChanged: (Map<String, dynamic>? data) {
                  setState(() {
                    selectedProduct = data;
                    print("Ausgewahlt ${data?['unit']}");
                    orderUnitController.text = data?['unit'] ?? '1';
                  });
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem?['product'] ?? 'wähle ein Produkt',
                    style: const TextStyle(color: Colors.green),
                  );
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Produkte",
                    hintText: "suche nach einem Produkt",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white)),
                    labelStyle: TextStyle(color: AppColors.green),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.s1),
              MyNumberField(
                text: 'Menge',
                isPassword: false,
                controller: orderQuantityController,
              ),
              MyTextField(
                controller: orderUnitController,
                text: 'Einheit',
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
