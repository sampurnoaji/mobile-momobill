import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:momobill/core/error/app_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'https://unsplash.com';

  Future<dynamic> get(String url) async {
    print('GET START --> ${_baseUrl + url}');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No internet connection');
      throw FetchDataException('No Internet connection');
    }
    print('GET END --> ${_baseUrl + url}');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('POST START --> ${_baseUrl + url}');
    print('Request Body: $body');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No internet connection');
      throw FetchDataException('No Internet connection');
    }
    print('POST END --> ${_baseUrl + url}');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('PUT START --> ${_baseUrl + url}');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No internet connection');
      throw FetchDataException('No Internet connection');
    }
    print('PUT END --> ${_baseUrl + url}');
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('DELETE START --> ${_baseUrl + url}');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No internet connection');
      throw FetchDataException('No Internet connection');
    }
    print('DELETE END --> ${_baseUrl + url}');
    return apiResponse;
  }

  Future<dynamic> mockGet(String url, String jsonFile) async {
    var data = await rootBundle.loadString(jsonFile);
    return json.decode(data);
  }

  Future<dynamic> mockPost(String url, dynamic request, String jsonFile) async {
    var data = await rootBundle.loadString(jsonFile);
    return json.decode(data);
  }
}

dynamic _returnResponse(http.Response response) {
  final statusCode = response.statusCode;
  print('Response Status code --> ${response.statusCode}');
  print('Response Body --> ${response.body}');
  if (statusCode == 200) {
    var responseJson = json.decode(response.body.toString());
    return responseJson;
  } else if (statusCode >= 400 && statusCode < 500) {
    throw ClientException(response.body.toString());
  } else if (statusCode >= 500 && statusCode < 600) {
    throw ServerException(response.body.toString());
  } else {
    throw FetchDataException('Error occured while Communication with Server');
  }
}
