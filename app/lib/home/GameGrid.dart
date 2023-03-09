import 'package:flutter/material.dart';
import '../data/GridGameWidget.dart';
import '../data/Game.dart';

class GameGrid extends StatelessWidget {
    final String heading;
    final List<Game> games;

    const GameGrid({
        required this.heading,
        Key? key,
        required this.games
    }) :super(key: key);

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(heading,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )
                ),
                Container(
                    height: 200,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                              (MediaQuery.of(context).size.height),
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                            return GridGameWidget(
                              game: games[index],
                            );
                        }
                    )
                )
            ]
        );
    }
}