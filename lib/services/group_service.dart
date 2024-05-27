import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'auth_service.dart';

class GroupService {
  final AuthService authService = AuthService();

  Future<http.Response?> createGroup(String groupname) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }

    String url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads';
    Map<String, dynamic> body = {"squadName": groupname};

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<bool> leaveGroup(String groupId) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return false;
    }

    final url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/leave/$groupId';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully left the group');
      return true;
    } else {
      print('Failed to leave the group with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  Future<http.Response?> joinGroup(String groupId) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }

    final url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/join/$groupId';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully join the group');
      return response;
    } else {
      print('Failed to leave the group with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }

  Future<List<Map<String, String>>?> groupCardInfo() async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/user'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseList = json.decode(response.body);
      return responseList.map((item) {
        return {
          'id': item['id'].toString(),
          'squadName': item['squadName'].toString()
        };
      }).toList();
    } else {
      // Handle the error
      return null;
    }
  }
}
