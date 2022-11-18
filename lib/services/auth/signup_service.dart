import 'dart:convert';
import 'package:http/http.dart' as http;
import 'routes.dart';

class SignUpService {
  signUp(String email, String password) async {
    Uri uri = Routes().urlSignUp;
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
