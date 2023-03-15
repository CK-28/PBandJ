
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
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage((game.imageId == null || game.imageId!.isEmpty)?
            "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png":
            game.getImageFromId("1080p")),
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