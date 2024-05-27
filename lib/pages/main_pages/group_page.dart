import 'package:flutter/material.dart';
import 'package:shopsquad/widgets/create_group.dart';
import 'package:shopsquad/widgets/footer_buttons.dart';
import 'package:shopsquad/widgets/group_card.dart';
import 'package:shopsquad/services/group_service.dart';
import 'package:shopsquad/widgets/join_group.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  static const IconData dots = IconData(0xe404, fontFamily: 'MaterialIcons');

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<Map<String, String>> squadNames = [];
  final GroupService groupService = GroupService();

  @override
  void initState() {
    super.initState();
    groupCardInfo();
  }

  Future<void> groupCardInfo() async {
    final squadList = await groupService.groupCardInfo();

    if (squadList != null) {
      setState(() {
        squadNames = squadList;
      });
    } else {
      print('Failed to fetch squad info');
    }
  }

  void addGroup() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: CreateGroup(
          onPressed: () {
            Navigator.pop(context);
            groupCardInfo();
          },
          onGroupCreated: groupCardInfo,
        ),
      ),
    );
  }

  void joinGroup() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: JoinGroup(
          onPressed: () {
            Navigator.pop(context);
            groupCardInfo();
          },
          onGroupCreated: groupCardInfo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: squadNames.map((squad) {
              return GroupCard(
                onTap: () {},
                title: squad['squadName']!,
                id: squad['id']!,
                onLeaveGroup: groupCardInfo, // Pass the refresh callback
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
