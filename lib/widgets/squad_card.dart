import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/services/squad_service.dart';

class SquadCard extends StatefulWidget {
  const SquadCard({
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
  SquadCardState createState() => SquadCardState();
}

class SquadCardState extends State<SquadCard> {
  bool _isLoading = false;
  final SquadService groupService = SquadService();

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
        const SnackBar(content: Text('Failed to leave the group')),
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
                leading: const Icon(deleteIcon),
                title: const Text('Verlassen'),
                onTap: () {
                  Navigator.of(context).pop();
                  leaveGroup(context);
                },
              ),
              ListTile(
                leading: const Icon(shareIcon),
                title: const Text('Gruppen ID teilen'),
                onTap: () {
                  Navigator.of(context).pop();
                  shareGroup(id);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
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
