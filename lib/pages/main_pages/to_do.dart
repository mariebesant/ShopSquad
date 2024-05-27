import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/to_do_card.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Map<String, dynamic>> listCardInfo = [
    {
      'isSortByPerson': false,
      'isChecked': true,
      'subtitle':
          'Music by Julie Gable. Lyrics by Sidney SteinMusic by Julie Gable. Lyrics by Sidney Stein.',
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

  void addGrocery() {}

  void completeShopping() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: listCardInfo.map((info) {
              return ToDoCard(
                isSortByPerson: info['isSortByPerson'],
                isChecked: info['isChecked'],
                subtitle: info['subtitle'],
                title: info['title'],
                trailing: info['trailing'],
              );
            }).toList(),
          ),
        ),
        FooterButtons(
          onPressedAdd: addGrocery,
          buttonText: 'EINKAUFEN',
          seconButtonPressed: completeShopping,
        )
      ],
    );
  }
}
