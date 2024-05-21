import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopsquad/widgets/group_card.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  static const IconData dots = IconData(0xe404, fontFamily: 'MaterialIcons');

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<Map<String, dynamic>> groupCardInfo = [
    {
      'title': 'AMC 23',
    },
    {
      'title': 'Reissalat',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: groupCardInfo.map((info) {
              return GroupCard(
                title: info['title'],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
