import 'package:flutter/material.dart';
import 'package:shopsquad/widgets/list_card.dart';
import 'package:shopsquad/widgets/to_do_card.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> listCardInfo = [
    {
      'subtitle':
          'Indicator',
      'title': 'Monday',
    },
    {
      'subtitle': 'Brot',
      'title': 'Das von Aldi',
    },
    // Weitere Map-Objekte können hier hinzugefügt werden...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listCardInfo.map((info) {
        return ListCard(
          subtitle: info['subtitle'],
          title: info['title'],
        );
      }).toList(),
    );
  }
}
