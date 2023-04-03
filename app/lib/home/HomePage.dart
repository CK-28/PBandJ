import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import 'GameGrid.dart';

class HomePage extends StatelessWidget {
  List<Game> games = gamesParser();

  // get game lists from databse
  // db.collection(users).doc(auth.user.id).collection("playing").get() or someting (to get whole collection)
  // might return Map
  // might need new version of gamesParser to parse map (very unlikely, especially if we do the below)
  // iterate through data from .get() and add to list
  // then call gamesParser on list

  // look at software design
  // onSnapshot to live update
  // userQuery = .get, which gets all user collection data, then  gets data for each thing and create new list
  // run games through gamesParser

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF8D5BC),
      child: ListView(
        padding: const EdgeInsets.all(10),
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