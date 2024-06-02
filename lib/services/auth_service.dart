import 'dart:convert';
import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> getAccessToken() async {
    String? accessToken = localStorage.getItem('accessBearer');

    if (accessToken != null) {
      accessToken = accessToken.substring(1, accessToken.length - 1);
    }
    return accessToken;
  }

  Future<String?> getUserID() async {
    String? accessToken = await getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/users'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic responseBody = json.decode(response.body);
      String? userId = responseBody['id'];
      return userId;
    } else {
      // Handle the error
      return null;
    }
  }
}
