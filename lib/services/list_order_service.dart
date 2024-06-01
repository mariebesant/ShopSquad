import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shopsquad/services/squad_service.dart';
import 'auth_service.dart';

class ListOrderService {
  final AuthService authService = AuthService();
  final SquadService squadService = SquadService();

  Future<http.Response?> createList(String listname, String squadID) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }

    String url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orderGroups';
    Map<String, dynamic> body = {
      "orderGroupName": listname,
      "squadId": squadID
    };

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

  Future<http.Response?> listCardInfo() async {
    String? accessToken = await authService.getAccessToken();

    final squad = await squadService.currentSquad();
    print(squad!.body);

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }

    final response = await http.post(
        Uri.parse(
            'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orderGroups/squad'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: squad.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle the error
      return null;
    }
  }

  Future<http.Response?> listOrders(http.Response orderResponse) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      print('Access token not found');
      return null;
    }
    print(orderResponse.body);

    final response = await http.post(
        Uri.parse(
            'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orders/orderGroup'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: orderResponse.body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle the error
      return null;
    }
  }
}
