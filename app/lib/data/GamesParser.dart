 import 'package:app/data/Game.dart';
 import 'dart:convert';

import 'package:app/data/data.dart';

List<Game> gamesParser() {
  return List<Game>.from(
    json.decode(jsonString).map((game) => Game.fromJson(game))
  );
}