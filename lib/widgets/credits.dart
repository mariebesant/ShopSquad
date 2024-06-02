import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/list_card.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  String credit = '-23,78';

  List<Map<String, dynamic>> creditInfo = [
    {
      'subtitle': 'marie@gmail.com',
      'title': 'Marie Besant',
      'trailing': 2.99,
    },
    {'subtitle': 'Brot', 'title': 'Kaan Cetin', 'trailing': -3.34},
    // Weitere Map-Objekte können hier hinzugefügt werden...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Schulde',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(
            height: AppSizes.s1,
          ),
          Text(
            credit,
            style: TextStyle(
                color: AppColors.warning,
                fontSize: AppSizes.s2,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: AppSizes.s0_5,
          ),
          Text(
            'saldo',
            style: TextStyle(
                color: AppColors.lightGray,
                fontSize: AppSizes.s1,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: AppSizes.s3_5,
          ),
          ListView(
            shrinkWrap: true, // ListView passt sich der verfügbaren Höhe an
            children: creditInfo.map((info) {
              return ListCard(
                  onDelete: () {},
                  onReceipt: () {},
                  subtitle: info['subtitle'],
                  title: info['title'],
                  backgroundColor: Colors.transparent,
                  trailing: Text(info['trailing'].toString(),
                      style: TextStyle(
                          color: AppColors
                              .lightGray))); // 'trailing' wird hier als Widget übergeben
            }).toList(),
          ),
        ],
      ),
    );
  }
}
