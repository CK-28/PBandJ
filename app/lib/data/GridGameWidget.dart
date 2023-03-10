
/*
  Build game cards with just cover art
*/

import 'package:flutter/material.dart';
import 'package:app/data/Game.dart';
import 'package:transparent_image/transparent_image.dart';

import '../GamePage/GamePage.dart';

class GridGameWidget extends StatelessWidget {
  final Game game;
  const GridGameWidget({Key? key, required this.game}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
      // height: 100,
      color: Color(0xFFF8D5BC),
      child: GestureDetector(
        child: Container(
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage((game.image == null)? "https://" : game.getImageFromId("1080p")),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(3, 5),
              ),
            ]
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GamePage(game: game)));
        },
      )
    )
      );
  }
}