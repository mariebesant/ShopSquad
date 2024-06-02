import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsquad/services/auth_service.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/list_card.dart';

class Credits extends StatefulWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  String credit = '-23,78';
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
      setState(() {
        creditInfo = responseList.where((item) {
          final bool isCreditor = item['creditorId'] == userID;
          final bool isDebitor = item['debitorID'] == userID;
          return isCreditor != isDebitor; // Either creditor or debitor but not both
        }).map<Map<String, dynamic>>((item) {
          return {
            'userName': 'Neu',
            'amount': item['amount'],
            'isCreditor': item['creditorId'] == userID,
          };
        }).toList();
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
      body: Column(
        children: [
          SizedBox(height: AppSizes.s1),
          Text(
            credit,
            style: TextStyle(
              color: AppColors.warning,
              fontSize: AppSizes.s2,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: AppSizes.s0_5),
          Text(
            'Saldo',
            style: TextStyle(
              color: AppColors.lightGray,
              fontSize: AppSizes.s1,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: AppSizes.s3_5),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: creditInfo.map((info) {
                return ListCard(
                  onDelete: () {},
                  onReceipt: () {},
                  subtitle: info['subtitle'],
                  title: info['userName'],
                  backgroundColor: Colors.transparent,
                  trailing: Text(
                    info['amount'].toString(),
                    style: TextStyle(
                      color: info['isCreditor']
                          ? AppColors.warning
                          : AppColors.success,
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
