import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api_and_localization/app/data/model/object_model.dart';

class ApiProvider {
  final String _baseUrl = "https://api.restful-api.dev/objects";
  Future <List<RestObject>> fetchObjects() async {
    final response = await http.get(Uri.parse(_baseUrl));
    print('API response: \\n' + response.body); // Debug print
    if (response.statusCode == 200) {
      List decoded = json.decode(response.body);
      return decoded.map((e) => RestObject.fromJson({
        'id': e['id'],
        'name': e['name'],
        // Ensure data is always a Map
        'data': e['data'] is Map<String, dynamic> ? e['data'] : {},
      })).toList();
    } else {
      throw Exception("Failed to load objects: ${response.statusCode}");
    }
  }
}

