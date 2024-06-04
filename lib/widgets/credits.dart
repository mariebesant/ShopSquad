import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopsquad/services/auth_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/list_card.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  double credit = 0.0;
  bool isLoading = false;
  List<dynamic> responseList = [];
  static const IconData paymentIcon =
      IconData(0xf265, fontFamily: 'MaterialIcons');

  final SquadService squadService = SquadService();
  final AuthService authService = AuthService();

  List<Map<String, dynamic>> creditInfo = [];

  Future<void> getAllDepts() async {
    setState(() {
      isLoading = true;
    });
    final response = await squadService.getCredits();
    final userID = await authService.getUserID();

    if (response != null && response.statusCode == 200) {
      responseList = json.decode(response.body);
      double calculatedCredit = 0.0;

      List<Map<String, dynamic>> filteredCredits = responseList.where((item) {
        final bool isCreditor = item['creditorId'] == userID;
        final bool isDebitor = item['debitorId'] == userID;
        return (isCreditor != isDebitor) && item['isPaid'] == false;
      }).map<Map<String, dynamic>>((item) {
        bool isCreditor = item['creditorId'] == userID;
        double amount = item['amount'];
        if (isCreditor) {
          calculatedCredit += amount;
        } else {
          calculatedCredit -= amount;
        }
        return {
          "id": item['id'],
          "creditorId": item['creditorId'],
          "creditorName": item['creditorName'],
          "creditorPaypal": item['creditorPaypal'],
          "debitorId": item['debitorId'],
          "debitorName": item['debitorName'],
          "debitorPaypal": item['debitorPaypal'],
          "createdAt": item['createdAt'],
          "isPaid": item['isPaid'],
          "paidAt": item['paidAt'],
          "orderId": item['orderId'],
          'amount': amount,
          'userName': 'Neu',
          'isCreditor': isCreditor,
        };
      }).toList();

      // Aggregating credits by user
      Map<String, Map<String, dynamic>> aggregatedMap = {};
      for (var item in filteredCredits) {
        String otherUserId = item['isCreditor'] ? item['debitorId'] : item['creditorId'];
        if (!aggregatedMap.containsKey(otherUserId)) {
          aggregatedMap[otherUserId] = {
            'userId': otherUserId,
            'userName': item['isCreditor'] ? item['debitorName'] : item['creditorName'],
            'userPaypal': item['isCreditor'] ? item['debitorPaypal'] : item['creditorPaypal'],
            'amount': 0.0,
          };
        }
        aggregatedMap[otherUserId]!['amount'] += item['isCreditor'] ? item['amount'] : -item['amount'];
      }

      List<Map<String, dynamic>> aggregatedCredits = aggregatedMap.values.map((entry) {
        return {
          'userId': entry['userId'],
          'userName': entry['userName'],
          'userPaypal': entry['userPaypal'],
          'amount': double.parse(entry['amount'].toStringAsFixed(2)),  // Round to 2 decimal places
        };
      }).toList();

      setState(() {
        creditInfo = aggregatedCredits;
        credit = double.parse(calculatedCredit.toStringAsFixed(2));  // Round to 2 decimal places
      });
      print(creditInfo);
    } else {
      print('Failed to get all Depts');
    }
    setState(() {
      isLoading = false;
    });
  }

  void payment(String? id) async {
    if (id != null && responseList != null) {
      responseList = responseList.map((info) {
        if (info['id'] == id) {
          info['isPaid'] = true;
        }
        return info;
      }).toList();

      // Extrahiere nur das aktualisierte Objekt in updatedCreditInfo
      final updatedCreditInfo =
          responseList.where((info) => info['id'] == id).toList();

      // print(updatedCreditInfo);
      await squadService.payment(updatedCreditInfo);
    }
    getAllDepts();
  }

  @override
  void initState() {
    super.initState();
    getAllDepts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Schulden',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.background,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.green))
          : Column(
              children: [
                const SizedBox(height: AppSizes.s1),
                Text(
                  credit.toStringAsFixed(2),
                  style: TextStyle(
                    color: credit >= 0 ? AppColors.success : AppColors.warning,
                    fontSize: AppSizes.s2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: AppSizes.s0_5),
                Text(
                  'Saldo',
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontSize: AppSizes.s1,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: AppSizes.s3_5),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: creditInfo.map((info) {
                      return ListCard(
                        isActive: false,
                        onDelete: () {},
                        onReceipt: () {},
                        subtitle: Text(
                          info['amount'].toStringAsFixed(2),  // Round to 2 decimal places
                          style: TextStyle(
                            color: info['amount'] >= 0
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                        ),
                        title: info['userName'],
                        backgroundColor: Colors.transparent,
                        trailing: info['amount'] >= 0
                            ? IconButton(
                                onPressed: () {
                                  payment(info['userId']); // Pass the 'id' to the payment method
                                },
                                icon: Icon(
                                  paymentIcon,
                                  color: AppColors.white,
                                ),
                              )
                            : SizedBox(),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
