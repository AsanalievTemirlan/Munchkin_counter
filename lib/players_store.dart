import 'dart:convert';
import 'package:munchkin/munchkin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayersStore {
  static const _key = 'players';

  final List<MunchkinModel> players = [];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return;

    final list = jsonDecode(jsonString) as List;
    players
      ..clear()
      ..addAll(list.map((e) => MunchkinModel.fromJson(e)));
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
    jsonEncode(players.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> resetStats() async {
    for (final p in players) {
      p.level = 0;
      p.might = 0;
    }
    await save();
  }

  Future<void> clear() async {
    players.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
