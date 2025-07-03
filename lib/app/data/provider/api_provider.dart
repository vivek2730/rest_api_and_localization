import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api_and_localization/app/data/model/object_model.dart';

class ApiProvider {
  final String _baseUrl = "https://api.restful-api.dev/objects";
  Future <List<RestObject>> fetchObjects() async {
    final response = await http.get(Uri.parse('$_baseUrl/objects'));
     if (response.statusCode == 200) {
      List decoded = json.decode(response.body);
      return decoded.map((e) => RestObject.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load objects");
    }
  }
}

