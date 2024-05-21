import 'package:flutter/material.dart';
import 'package:shopsquad/widgets/list_card.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> listCardInfo = [
    {
      'subtitle': 'Indicator',
      'title': 'Monday',
    },
    {
      'subtitle': 'Brot',
      'title': 'Das von Aldi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: listCardInfo.map((info) {
              return ListCard(
                subtitle: const MyProgressIndicator(totalTasks: 5, completedTasks: 3),
                title: info['title'],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
