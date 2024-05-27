import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/group_page.dart';
import 'package:shopsquad/pages/main_pages/profile_page.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';
import 'package:shopsquad/pages/main_pages/to_do.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_button.dart';
import 'package:shopsquad/widgets/my_icon_button.dart';

enum MainPagesSlides { list, group, profile }

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final PageController _controller = PageController();
  final List<MainPagesSlides> _content = MainPagesSlides.values;
  int currentIndex = 0;
  bool isSelected = false;

  static const IconData profileIcon =
      IconData(0xee35, fontFamily: 'MaterialIcons');
  static const IconData groupsIcon =
      IconData(0xf08a8, fontFamily: 'MaterialIcons');
  static const IconData listIcon =
      IconData(0xf85e, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');

  Widget getSlide(BuildContext context, int index) {
    switch (_content[index]) {
      case MainPagesSlides.group:
        return const GroupPage();
      case MainPagesSlides.list:
        return const ToDo();
      case MainPagesSlides.profile:
        return ProfilePage();
    }
  }

  void onPressed(int index) {
    setState(() {
      currentIndex = index;
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void addGrocery() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Gruppenname',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.s1, horizontal: AppSizes.s1_25),
            child: MyProgressIndicator(totalTasks: 5, completedTasks: 3),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: getSlide(context, index),
                );
              },
              controller: _controller,
              itemCount: _content.length,
            ),
          ),
          Container(
              height: AppSizes.s6,
              decoration: BoxDecoration(
                color: AppColors.accentGray,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyIconButton(
                        isSelected: currentIndex == 0,
                        currentSlide: 'Liste',
                        onPressed: () => onPressed(0),
                        icon: listIcon),
                    MyIconButton(
                        isSelected: currentIndex == 1,
                        currentSlide: 'Gruppe',
                        onPressed: () => onPressed(1),
                        icon: groupsIcon),
                    MyIconButton(
                        isSelected: currentIndex == 2,
                        currentSlide: 'Profil',
                        onPressed: () => onPressed(2),
                        icon: profileIcon)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
