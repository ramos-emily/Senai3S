import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  // Salvar string simples
  static Future<void> salvarString(String chave, String valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, valor);
  }

  // Ler string simples
  static Future<String?> lerString(String chave) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(chave);
  }

  // Salvar JSON no cache
  static Future<void> salvarJson(String chave, Map<String, dynamic> valor) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(valor);
    await prefs.setString(chave, jsonString);
  }

  // Ler JSON no cache
  static Future<Map<String, dynamic>?> lerJson(String chave) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(chave);

    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  // Remover dado
  static Future<void> remover(String chave) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(chave);
  }
}
