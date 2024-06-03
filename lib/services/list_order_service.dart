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
      // ignore: avoid_print
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
    body: squad!.body,
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> filteredResponse = jsonResponse
        .where((orderGroup) => orderGroup['isFinished'] == false)
        .toList();
    
    // Create a new Response with the filtered body
    return http.Response(jsonEncode(filteredResponse), 200, headers: response.headers);
  } else {
    // Handle the error
    return null;
  }
}

  Future<http.Response?> listOrders(http.Response orderResponse) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.post(
        Uri.parse(
            'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orders/orderGroup'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: orderResponse.body);

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle the error
      return null;
    }
  }

  Future<http.Response?> createOrder(String body) async {
    String? accessToken = await authService.getAccessToken();

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }

    final response = await http.post(
        Uri.parse(
            'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orders'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: body);

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle the error
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getProducts() async {
    final response = await http.get(Uri.parse(
      'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/products',
    ));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(
          responseData.map((item) => item as Map<String, dynamic>));
      return products;
    } else {
      // Handle den Fehler entsprechend
      return null;
    }
  }

  Future<http.Response?> completeOrder(List<Map<String, dynamic>> body) async {
    String? accessToken = await authService.getAccessToken();
    String? userID = await authService.getUserID();
    String jsonBody = json.encode(body);

    if (accessToken == null) {
      // ignore: avoid_print
      print('Access token not found');
      return null;
    }
    if (userID == null) {
      // ignore: avoid_print
      print('User ID not found');
      return null;
    }

    final url =
        'https://europe-west1-shopsquad-8cac8.cloudfunctions.net/app/api/orderGroups/$userID/finish';

    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: jsonBody);

    if (response.statusCode == 200) {
      return response;
    } else {
      // Handle the error
      return null;
    }
  }
}
