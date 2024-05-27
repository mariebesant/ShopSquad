import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

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

  static const IconData deleteIcon = IconData(0xf696, fontFamily: 'MaterialIcons');
  static const IconData shareIcon = Icons.share;
  static const IconData menu = IconData(0xf8dc, fontFamily: 'MaterialIcons');

  Future<void> leaveGroup(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String? accessToken = localStorage.getItem('accessBearer');
    if (accessToken == null) {
      print('Access token not found');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    
    accessToken = accessToken.substring(1, accessToken.length - 1);
    print(widget.id);

    final url = 'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/leave/${widget.id}';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'squadId': widget.id,
        'Content-Type': 'application/json',
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      print('Successfully left the group');
      widget.onLeaveGroup();
    } else {
      print('Failed to leave the group with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

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
                // Add share functionality here
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
              onPressed: () => showOptionsDialog(context),
            ),
          ),
        ),
      ),
    );
  }
}
