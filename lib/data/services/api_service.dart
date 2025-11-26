import 'dart:convert';

import 'package:http/http.dart' as http; // Para http requests

class ApiService {
  static const String baseUrl = 'https://restaurantapi-0-0-1.onrender.com/';

  static Future<http.Response> getWithAuth(String endpoint, String token) async {
    return await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(token),
    );
  }
  
  static Future<http.Response> postWithAuth(String endpoint, String token, {Map<String, dynamic>? body}) async {
    return await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(token),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    return await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(''),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> patch(String endpoint, String token, {Map<String, dynamic>? body}) async {
    return await http.patch(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(token),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> put(String endpoint, String token, {Map<String, dynamic>? body}) async {
    return await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(token),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> delete(String endpoint, String token, {Map<String, dynamic>? body}) async {
    return await http.delete(
      Uri.parse(baseUrl + endpoint),
      headers: _buildHeaders(token),
      body: body != null ? jsonEncode(body) : null,
    );
  }
  
  static Map<String, String> _buildHeaders(String token) {
    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }

}