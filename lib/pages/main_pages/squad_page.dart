import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/widgets/create_squad.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/squad_card.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/widgets/join_squad.dart';

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  static const IconData dots = IconData(0xe404, fontFamily: 'MaterialIcons');

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  List<Map<String, String>> squadNames = [];
  final SquadService groupService = SquadService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    squadCardInfo();
  }

  Future<void> squadCardInfo() async {
    setState(() {
      isLoading = true;
    });

    final squadList = await groupService.squadCardInfo();

    if (squadList != null) {
      setState(() {
        squadNames = squadList;
      });
    } else {
      // ignore: avoid_print
      print('Failed to fetch squad info');
    }

    setState(() {
      isLoading = false;
    });
  }

  void addGroup() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: CreateSquad(
          onPressed: () {
            Navigator.pop(context);
            squadCardInfo();
          },
          onGroupCreated: squadCardInfo,
        ),
      ),
    );
  }

  void joinGroup() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: JoinSquad(
          onPressed: () {
            Navigator.pop(context);
            squadCardInfo();
          },
          onGroupCreated: squadCardInfo,
        ),
      ),
    );
  }

  Future<void> changeCurrentSquad(String id) async {
    final response = await groupService.changeCurrentSquad(id);
    if (response != null && response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<dynamic>(
          builder: (context) => const MainPages(),
        ),
        (route) => false,
      );
    } else {
      // ignore: avoid_print
      print('Failed to change current squad');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator(color: AppColors.green)
        : Column(
            children: [
              Expanded(
                child: ListView(
                  children: squadNames.map((squad) {
                    return SquadCard(
                      onTap: () => changeCurrentSquad(squad['id']!),
                      title: squad['squadName']!,
                      id: squad['id']!,
                      onLeaveGroup: squadCardInfo, // Pass the refresh callback
                    );
                  }).toList(),
                ),
              ),
              FooterButtons(
                onPressedAdd: addGroup,
                buttonText: 'BEITRETEN',
                seconButtonPressed: joinGroup,
              )
            ],
          );
  }
}
