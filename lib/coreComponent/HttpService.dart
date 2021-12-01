import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../environment.dart';

class HttpService {
  Future<dynamic> getAsync(String api) async {
    var response = await http.Client()
        .get(Uri.parse(_getUrl(api)), headers: await _getHeaders2());
    return _handleResponse(response);
  }

  Future<dynamic> postAsync(String api, Map<String, dynamic> body) async {
    var bodyJson = json.encode(body);
    var response = await http.Client().post(Uri.parse(_getUrl(api)),
        body: bodyJson, headers: await _getHeaders2());
    return _handleResponse(response);
  }

  Future<dynamic> putAsync(String api, Map<String, dynamic> body) async {
    var bodyJson = json.encode(body);
    var response = await http.Client().put(Uri.parse(_getUrl(api)),
        body: bodyJson, headers: await _getHeaders());
    return _handleResponse(response);
  }

  Future<dynamic> deleteAsync(String api, String id) async {
    var apiUrl = Uri.parse("${_getUrl(api)}/$id");
    var response =
        await http.Client().delete(apiUrl, headers: await _getHeaders2());
    return _handleResponse(response);
  }

  // region Helper Methods
  String _getUrl(String api) {
    return "${environment["BASE_URL"]}$api";
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  Future<Map<String, String>> _getHeaders2() async {
    return {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
    };
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw response.body;
    }

    final parsed = json.decode(response.body);
    // final parsed = response.body;
    return parsed;
  }
  // endregion
}
