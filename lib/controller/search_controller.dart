import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/search_model.dart';

class ApiController {
  static const String _apiBaseUrl = 'https://api.tvmaze.com';

  Future<List<Show>> searchShows(String query) async {
    final url = Uri.parse('$_apiBaseUrl/search/shows?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => Show.fromJson(json['show'])).toList();
    } else {
      throw Exception('Failed to search shows');
    }
  }
}
