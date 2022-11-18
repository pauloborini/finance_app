import 'dart:convert';
import 'package:http/http.dart' as http;
import 'routes.dart';

class SigningService {
  signing(String email, int password) async {
    Uri uri = Routes().urlSignIn;
    http.Response response = await http.post(
      uri,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    print(response.body);
  }
}
