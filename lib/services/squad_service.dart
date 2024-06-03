import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'auth_service.dart';

class SquadService {
  final AuthService authService = AuthService();

  Future<http.Response?> createSquad(String groupname) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
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

  Future<bool> leaveSquad(String squadID) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return false;
    }

    final url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/leave/$squadID';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // ignore: avoid_print
      print('Failed to leave the group with status: ${response.statusCode}');
      return false;
    }
  }

  Future<http.Response?> joinSquad(String squadId) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/join/$squadId';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      // ignore: avoid_print
      print('Failed to leave the group with status: ${response.statusCode}');
      return null;
    }
  }

  Future<http.Response?> changeCurrentSquad(String squadId) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.put(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/user/currentSquad/$squadId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response?> currentSquad() async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/squads/user/currentSquad'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle den Fehler entsprechend
      return null;
    }
  }

  Future<List<Map<String, String>>?> squadCardInfo() async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
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

  Future<http.Response?> getCredits() async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/debts/user'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle den Fehler entsprechend
      return null;
    }
  }

  Future<String> getImageLink() async {
    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/examples/imageLink'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Handle den Fehler entsprechend
      return '';
    }
  }
}
