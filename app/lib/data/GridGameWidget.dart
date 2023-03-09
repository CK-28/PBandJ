
/*
  Build game cards with just cover art
*/

import 'package:flutter/material.dart';
import 'package:app/data/Game.dart';
import 'package:transparent_image/transparent_image.dart';

class GridGameWidget extends StatelessWidget {
  final Game game;
  const GridGameWidget({Key? key, required this.game}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 10000,
      // height: 128,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkImage((game.image == null)? "https://" : "https:${game.image}"),
        // fit: BoxFit.contain,
      )
    );
  }
}