import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sequel/managers/password_manager.dart';

class ApiManager {
  static String _apiKey = "";

  static initializeApiKey() async {
    if (_apiKey.isEmpty) {
      _apiKey = await PasswordManager().getKey();
    }
  }

  Future<Map<String, dynamic>> _processRequest(String query) async {
    initializeApiKey();

    Response response = await get(
      Uri.parse(query),
    );

    _checkResponse(response);
    return jsonDecode(response.body);
  }

  void _checkResponse(Response response) {
    if (response.statusCode != 200) {
      throw HttpException("Bad status code: ${response.statusCode}");
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    String errorMessage = responseBody['errorMessage'];

    if (errorMessage.isNotEmpty) {
      throw HttpException("Error occured: $errorMessage");
    }
  }

  Future<Map<String, dynamic>> getTop250() async {
    return _processRequest(
      'https://imdb-api.com/en/API/Top250Movies/$_apiKey',
    );
  }

  Future<Map<String, dynamic>> getTop100() async {
    Map<String, dynamic> result = {};
    Map<String, dynamic> top250 = await getTop250();

    for (String key in top250.keys) {
      if (result.keys.length < 100) {
        result[key] = top250[key];
      } else {
        break;
      }
    }

    return result;
  }

  Future<Map<String, dynamic>> getFilmImageById(String id) async {
    return _processRequest(
      'https://imdb-api.com/en/API/Images/$_apiKey/$id/Short',
    );
  }

  Future<Map<String, dynamic>> getFilmFulcastById(String id) async {
    return _processRequest(
      'https://imdb-api.com/en/API/Title/$_apiKey/$id/FullCast,',
    );
  }

  Future<Map<String, dynamic>> getTagLineById(String id) async {
    return _processRequest(
      'https://imdb-api.com/en/API/Title/$_apiKey/$id/Posters,',
    );
  }

  Future<Map<String, dynamic>> getAllTimeBoxOffice() async {
    return _processRequest(
      'https://imdb-api.com/en/API/BoxOfficeAllTime/$_apiKey',
    );
  }
}
