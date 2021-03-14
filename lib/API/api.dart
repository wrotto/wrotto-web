import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:wrotto_web/API/app_exception.dart';
import 'package:wrotto_web/models/journal_entry.dart';

class Api {
  final String _baseUrl = "http://127.0.0.1:8000/api/";
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
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final response = await get("entries/");
    return response['results']
        .forEach((entry) => JournalEntry.fromJson(entry))
        .toList();
  }

  Future<List<String>> getTags() async {
    final response = await get("tags/");
    return response['results'].toList();
  }
}
