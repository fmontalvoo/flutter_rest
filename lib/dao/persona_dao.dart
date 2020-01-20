import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rest/model/persona.dart';

class PersonaDAO {
  static const String IP = '0.0.0.0';
  static const int PORT = 3000;
  static const String URL = 'http://$IP:$PORT/persona';

  static Future<Persona> fetchPost() async {
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falló en recuperar la persona');
    }
  }
}
