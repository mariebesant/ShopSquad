import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shopsquad/widgets/group_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  static const IconData dots = IconData(0xe404, fontFamily: 'MaterialIcons');

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<dynamic> squadNames = [];

  @override
  void initState() {
    super.initState();
    fetchGroupCardInfo();
  }

  Future<void> fetchGroupCardInfo() async {
    print('Top');
    String? accessToken = localStorage.getItem('accessBearer');
    if (accessToken == null) {
      print('Access token not found');
      return;
    }
    accessToken = accessToken.substring(1, accessToken.length - 1);

    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/user'),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer $accessToken',
      },
    );

    print(accessToken);
    print(response.body);

    if (response.statusCode == 200) {
      print('Top');
      setState(() {
        List<dynamic> responseList = json.decode(response.body);
        squadNames = responseList.map((item) => item['squadName'].toString()).toList();
      });
    } else {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: squadNames.map((name) {
              return GroupCard(
                onTap: () {},
                title: name,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
