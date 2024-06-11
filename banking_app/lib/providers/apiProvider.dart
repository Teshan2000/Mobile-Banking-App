import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<String> _getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }

  Future<int> _getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('user_id') ?? 0;
  }

  Future<http.Response> postRequest(
      {required String route, required Map<String, dynamic> data}) async {
    final url = Uri.parse('$baseUrl$route');
    final token = await _getToken();
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response;
    } catch (e) {
      print('Error making POST request: $e');
      rethrow;
    }
  }
}
