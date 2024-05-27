import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/list_card.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  static const IconData moneyIcon =
      IconData(0xf1dd, fontFamily: 'MaterialIcons');

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

  void addList() {}

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
                trailing: Icon(moneyIcon, color: AppColors.white,),
                backgroundColor: AppColors.accentGray,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ToDoPage(),
                    ),
                  );
                }, // onTap Funktion hier definiert
              );
            }).toList(),
          ),
        ),
        FooterButtons(onPressedAdd: addList, isShoped: false)
      ],
    );
  }
}
