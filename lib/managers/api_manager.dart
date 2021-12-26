import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class ApiManager {
  // static const String _apiKey = 'k_8qyf2u4e';
  // static const String _apiKey = 'k_n8ccr4o7';
  // static const String _apiKey = 'k_gb63ddzt';
  // static const String _apiKey = 'k_xwe71f28';
  // static const String _apiKey = 'k_gt620dn8';
  // static const String _apiKey = 'k_dc46p11z';
  // static const String _apiKey = 'k_a3us5k68';
  // static const String _apiKey = 'k_n8oc1vb7';
  // static const String _apiKey = 'k_9c19lhqt';
  static const String _apiKey = 'k_uu7p7hxq';

  Future<Map<String, dynamic>> _processRequest(String query) async {
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
