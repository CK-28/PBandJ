import 'package:app/SearchPage/ListGameWidget.dart';
import 'package:flutter/material.dart';
import '../data/Game.dart';

class SearchGamesListWidget extends StatelessWidget {
  final List<Game> games;
  const SearchGamesListWidget({Key? key, required this.games}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return (games.isNotEmpty) ?
      Flexible(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListGameWidget(
                game: games[index],
                isSmall: false, //may need to be small if on smaller screen as the tags can overflow and throw errors on the screen
              );
            },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: games.length,
        ),
      ) : const Center(
        child: Text(
          "No Games Found",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )
      );
  }
}

