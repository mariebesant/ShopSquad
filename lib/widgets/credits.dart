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
      List<dynamic> responseList = json.decode(response.body);
      double calculatedCredit = 0.0;

      List<Map<String, dynamic>> filteredCredits = responseList.where((item) {
        final bool isCreditor = item['creditorId'] == userID;
        final bool isDebitor = item['debitorId'] == userID;
        return isCreditor != isDebitor; // Either creditor or debitor but not both
      }).map<Map<String, dynamic>>((item) {
        bool isCreditor = item['creditorId'] == userID;
        double amount = item['amount'];
        if (isCreditor) {
          calculatedCredit += amount;
        } else {
          calculatedCredit -= amount;
        }
        return {
          'userName': 'Neu',
          'amount': amount,
          'isCreditor': isCreditor,
          "creditorName": item['creditorName'],
          "debitorName": item['debitorName'],
        };
      }).toList();

      setState(() {
        creditInfo = filteredCredits;
        credit = calculatedCredit;
      });
    } else {
      print('Failed to get all Depts');
    }
    setState(() {
      isLoading = false;
    });
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
                        subtitle: info['userName'],
                        title: info['isCreditor']
                            ? info['debitorName']
                            : info['creditorName'],
                        backgroundColor: Colors.transparent,
                        trailing: Text(
                          info['amount'].toString(),
                          style: TextStyle(
                            color: info['isCreditor']
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
