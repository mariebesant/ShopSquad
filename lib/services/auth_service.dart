import 'package:localstorage/localstorage.dart';

class AuthService {

  Future<String?> getAccessToken() async {
    String? accessToken = localStorage.getItem('accessBearer');
    
    if (accessToken != null) {
      accessToken = accessToken.substring(1, accessToken.length - 1);
    }
    return accessToken;
  }
}
