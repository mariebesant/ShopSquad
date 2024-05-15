import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/list_card.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> listCardInfo = [
    {
      'isSortByPerson': false,
      'isChecked': true,
      'subtitle': 'Music by Julie Gable. Lyrics by Sidney SteinMusic by Julie Gable. Lyrics by Sidney Stein.',
      'title': 'The Enchanted Nightingale',
      'trailing': '2'
    },
    {
      'isSortByPerson': false,
      'isChecked': true,
      'subtitle': 'Brot',
      'title': 'Das von Aldi',
      'trailing': '2'
    },
    // Weitere Map-Objekte können hier hinzugefügt werden...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: listCardInfo.map((info) {
          return ListCard(
            isSortByPerson: info['isSortByPerson'],
            isChecked: info['isChecked'],
            subtitle: info['subtitle'],
            title: info['title'],
            trailing: info['trailing'],
          );
        }).toList(),
      );
  }
}
