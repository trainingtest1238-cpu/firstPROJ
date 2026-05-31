import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  String ip = "http://192.168.0.133:";
  String port = "8060";
  late String url = ip + port;

  Future<Map<String, String>> _getHeaders({bool isJson = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    return {
      "Accept": "application/json",
      if (isJson) "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> getRequest(String url) async {
    final res = await http.get(Uri.parse(url), headers: await _getHeaders());

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception(
        'get request failed, the status code is :${res.statusCode}',
      );
    }
  }

  Future<dynamic> postRequest(String url, Map data) async {
    final res = await http.post(
      Uri.parse(url),
      headers: await _getHeaders(isJson: true),
      body: jsonEncode(data),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    } else {
      throw Exception('post request failes :${res.statusCode}');
    }
  }

  Future<dynamic> putRequest(String url, Map data) async {
    final res = await http.put(
      Uri.parse(url),
      headers: await _getHeaders(isJson: true),
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('put request failes :${res.statusCode}');
    }
  }

  Future<dynamic> deleteRequest(String url, Map data) async {
    final res = await http.delete(
      Uri.parse(url),
      headers: await _getHeaders(isJson: true),
    );

    return res.body.isNotEmpty ? jsonDecode(res.body) : null;
  }
}
