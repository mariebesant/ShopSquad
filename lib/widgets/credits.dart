import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/list_card.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  List<Map<String, dynamic>> creditInfo = [
    {
      'subtitle':
          'marie@gmail.com',
      'title': 'Marie Besant',
      'trailing': 2.99, 
    },
    {'subtitle': 'Brot', 'title': 'Kaan Cetin', 'trailing': -3.34}, 
    // Weitere Map-Objekte können hier hinzugefügt werden...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true, // ListView passt sich der verfügbaren Höhe an
        children: creditInfo.map((info) {
          return ListCard(
              onDelete: () {
                
              },
              onReceipt: () {
                
              },
              title: info['title'],
              backgroundColor: Colors.transparent,
              trailing: Text(info['trailing'].toString(), style: TextStyle(color: AppColors.lightGray))); // 'trailing' wird hier als Widget übergeben
        }).toList(),
    );
  }
}
