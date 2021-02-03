import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:momobill/core/error/app_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'https://unsplash.com';

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    } else if (statusCode >= 400 && statusCode < 500) {
      throw ClientException(response.body.toString());
    } else if (statusCode >= 500 && statusCode < 600) {
      throw ServerException(response.body.toString());
    } else {
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
