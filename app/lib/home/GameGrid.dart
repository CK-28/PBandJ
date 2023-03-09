/*
  Grid of two rows of games
*/

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
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
                Container(
                    // color: Color(0xFFEF6F0CC),
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: (5/4),
                          ),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                              return GridGameWidget(
                                game: games[index],
                              );
                          }
                      )
                    ),
                  )
            ]
        );
    }
}