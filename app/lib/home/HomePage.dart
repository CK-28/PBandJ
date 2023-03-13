import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import 'GameGrid.dart';

class HomePage extends StatelessWidget {
  List<Game> games = gamesParser();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF8D5BC),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
      )
    );
  }
}