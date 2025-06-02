import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/saison.dart';
import '../models/episode.dart';
import '../models/personnage.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<String> createEpisode({
    required String titre,
    required String resume,
    required int numero,
    required String image,
    required String saisonId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/episodes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'titre': titre,
        'resume': resume,
        'numero': numero,
        'image': image,
        'saison_id': saisonId,
      }),
    );
    final data = json.decode(response.body);
    return data['_id'];
  }

  static Future<List<Saison>> getSaisons() async {
    final response = await http.get(Uri.parse('$baseUrl/saisons'));
    final List data = json.decode(response.body);
    return data.map((json) => Saison.fromJson(json)).toList();
  }

  static Future<List<Episode>> getEpisodesBySaison(String saisonId) async {
    final response = await http.get(Uri.parse('$baseUrl/saisons/$saisonId/episodes'));
    final List data = json.decode(response.body);
    return data.map((json) => Episode.fromJson(json)).toList();
  }

  static Future<Map<String, dynamic>> getEpisodeById(String episodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/episodes/$episodeId'));
    return json.decode(response.body);
  }

  static Future<List<Personnage>> getPersonnagesByEpisode(String episodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/episodes/$episodeId/personnages'));
    final List data = json.decode(response.body);
    return data.map((json) => Personnage.fromJson(json)).toList();
  }

  static Future<Map<String, dynamic>> getEpisodeByIdComplete(String episodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/episodes/$episodeId/complete'));
    return json.decode(response.body);
  }

  static Future<List<Personnage>> getPersonnages() async {
    final response = await http.get(Uri.parse('$baseUrl/personnages'));
    final List data = json.decode(response.body);
    return data.map((json) => Personnage.fromJson(json)).toList();
  }

  static Future<List<Episode>> getEpisodesByPersonnage(String personnageId) async {
    final response = await http.get(Uri.parse('$baseUrl/personnages/$personnageId/episodes'));
    final List data = json.decode(response.body);
    return data.map((json) => Episode.fromJson(json)).toList();
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    return data['success'] == true;
  }

  static Future<void> createSaison(String titre) async {
    await http.post(
      Uri.parse('$baseUrl/saisons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'titre': titre}),
    );
  }

  static Future<void> addPersonnagesToEpisode(String episodeId, List<String> personnagesIds) async {
    await http.post(
      Uri.parse('$baseUrl/episodes/$episodeId/personnages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'personnages_ids': personnagesIds}),
    );
  }
}