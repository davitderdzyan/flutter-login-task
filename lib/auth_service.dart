import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService {
  static const String baseUrl = 'https://stylrapi.production.am';

  static Future<Response> signUp(
      String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Sign-up successful!');
    } else {
      print('Sign-up failed. Error code: ${response.statusCode}');
    }

    return response;
  }

  static Future<Response> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Sign-in successful!');
    } else {
      print('Sign-in failed. Error code: ${response.statusCode}');
    }

    return response;
  }

  static Future sendVerificationCode(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/verify/send-code'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Verification Code sent!');
    } else {
      print(
          'Verification code send failed. Error code: ${response.statusCode}');
    }

    return response;
  }

  static Future<Response> verifyVerificationCode(String email, code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/verify/verify-code'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'code': code,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Verification successful!');
    } else {
      print('Verification failed. Error code: ${response.statusCode}');
    }

    return response;
  }
}
