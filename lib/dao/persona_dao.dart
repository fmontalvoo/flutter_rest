import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rest/model/persona.dart';

class PersonaDAO {
  static const String IP = '172.16.2.73';
  static const int PORT = 3000;
  static const String URL = 'http://$IP:$PORT/persona';

  static Future crearPersona(json) async {
    http.Response response = await http.post(URL,
        body: json,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'));
    return response;
  }

  static Future<Persona> leerPersona(int id) async {
    final response = await http.get('$URL/$id');
    if (response.statusCode == 200) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falló en recuperar la persona');
    }
  }

  static Future actualizarPersona(json, int codigo) async {
    http.Response response = await http.put('$URL/$codigo',
        body: json,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'));
    return response;
  }

  static Future eliminarPersona(int id) async {
    http.Response response = await http.delete('$URL/$id');
    return response;
  }

  static Future<List<Persona>> listarPersona() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      return _toListPersona(response.body);
    } else {
      throw Exception('Falló al recuperar la lista de personas');
    }
  }

  static List<Persona> _toListPersona(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
  }
}
