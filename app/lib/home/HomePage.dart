import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import 'GameGrid.dart';

class HomePage extends StatelessWidget {
  List<Game> games = gamesParser();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
            GameGrid(
                heading: "Playing",
                games: games,
            ),
            GameGrid(
                heading: "Backlog",
                games: games,
            ),
            GameGrid(
                heading: "Ongoing",
                games: games,
            ),
        ]
    );
  }
}