import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class ListCard extends StatefulWidget {
  const ListCard(
      {super.key,
      required this.title,
      this.subtitle,
      required this.backgroundColor,
      this.trailing,
      this.onTap,
      required this.onDelete,
      required this.onReceipt,
      required this.isActive});

  final String title;
  final Color backgroundColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback onDelete;
  final VoidCallback onReceipt;
  final String? subtitle;
  final bool isActive;

  @override
  ListCardState createState() => ListCardState();
}

class ListCardState extends State<ListCard> {
  bool _isLoading = false;

  static const IconData deleteIcon =
      IconData(0xf696, fontFamily: 'MaterialIcons');
  static const IconData moneyIcon =
      IconData(0xf58f, fontFamily: 'MaterialIcons');
  static const IconData menu = IconData(0xf8dc, fontFamily: 'MaterialIcons');

  void showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: !_isLoading, // Prevent dismissing when loading
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(moneyIcon),
                title: const Text('Belege'),
                subtitle: Text(widget.subtitle != null ? widget.subtitle! : ''),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onReceipt();
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
      child: GestureDetector(
        onTap: widget.isActive
            ? widget.onTap
            : () {}, 
        child: Container(
          decoration: BoxDecoration(
            color: widget.isActive ? AppColors.success : widget.backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(color: AppColors.white),
            ),
            trailing: widget.trailing ??
                (widget.isActive
                    ? null
                    : IconButton(
                        onPressed: () {},
                        icon: Icon(
                          moneyIcon,
                          color: AppColors.white,
                        ))),
          ),
        ),
      ),
    );
  }
}
