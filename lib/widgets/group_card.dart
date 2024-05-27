import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/services/group_service.dart';

class GroupCard extends StatefulWidget {
  const GroupCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.id,
    required this.onLeaveGroup,
  });

  final String title;
  final VoidCallback onTap;
  final String id;
  final VoidCallback onLeaveGroup;

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool _isLoading = false;
  final GroupService groupService = GroupService();

  static const IconData deleteIcon =
      IconData(0xf696, fontFamily: 'MaterialIcons');
  static const IconData shareIcon = Icons.share;
  static const IconData menu = IconData(0xf8dc, fontFamily: 'MaterialIcons');

  Future<void> leaveGroup(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    bool success = await groupService.leaveGroup(widget.id);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      widget.onLeaveGroup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to leave the group')),
      );
    }
  }

  Future<void> shareGroup(String id) async {
    await Share.share(
      'Werde teil eines ShopSquads! $id',
    );
  }

  void showOptionsDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: !_isLoading, // Prevent dismissing when loading
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(deleteIcon),
                title: Text('Verlassen'),
                onTap: () {
                  Navigator.of(context).pop();
                  leaveGroup(context);
                },
              ),
              ListTile(
                leading: Icon(shareIcon),
                title: Text('Gruppen ID teilen'),
                onTap: () {
                  Navigator.of(context).pop();
                  shareGroup(id);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.s0_5,
        horizontal: AppSizes.s1,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accentGray,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(color: AppColors.white),
            ),
            trailing: IconButton(
              icon: Icon(menu, color: AppColors.white),
              onPressed: () => showOptionsDialog(context, widget.id),
            ),
          ),
        ),
      ),
    );
  }
}
