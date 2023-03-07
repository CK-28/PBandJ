
// import 'package:app/SearchPage/SearchFieldWidget.dart';
import 'package:app/SearchPage/SearchGamesListWidget.dart';
import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Game> games = gamesParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Center(
          child:Column(
          children: [
            // SearchFieldWidget(), //Search section
            SearchGamesListWidget(games: games),
          ],
        )
      )
    );
  }
}