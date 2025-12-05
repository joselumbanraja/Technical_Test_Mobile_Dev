import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/people.dart';

class ApiService {
  Future<List<People>> fetchPeople() async {
    final url = Uri.parse('https://swapi.dev/api/people/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];

      return results.map((item) => People.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
