import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/squad_page.dart';
import 'package:shopsquad/pages/main_pages/list_page.dart';
import 'package:shopsquad/pages/main_pages/profile_page.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_icon_button.dart';

enum MainPagesSlides { list, group, profile }

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  final PageController _controller = PageController();
  final List<MainPagesSlides> _content = MainPagesSlides.values;
  int currentIndex = 0;
  bool isSelected = false;
  String currentSquad = '';
  String title = '';

  final SquadService groupService = SquadService();

  static const IconData profileIcon =
      IconData(0xee35, fontFamily: 'MaterialIcons');
  static const IconData groupsIcon =
      IconData(0xf08a8, fontFamily: 'MaterialIcons');
  static const IconData listIcon =
      IconData(0xf85e, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    loadCurrentSquad();
    super.initState();
  }

  Future<void> loadCurrentSquad() async {
    final squad = await groupService.currentSquad();
    print(squad);
    setState(() {
      currentSquad = squad ?? 'Gruppe';
    });
  }

  Widget getSlide(BuildContext context, int index) {
    switch (_content[index]) {
      case MainPagesSlides.group:
        title = currentSquad;
        return const SquadPage();
      case MainPagesSlides.list:
        title = currentSquad;
        return const ListPage();
      case MainPagesSlides.profile:
        title = 'Dein Profil';
        return const ProfilePage();
      default:
        return const ListPage();
    }
  }

  void onPressed(int index) {
    setState(() {
      currentIndex = index;
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          title,
          style: TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                onPressed(index); // Ensure title is updated on page change
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
            ),
          )
        ],
      ),
    );
  }
}
