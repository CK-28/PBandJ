
import 'package:flutter/material.dart';
import 'package:app/data/Game.dart';
import 'package:transparent_image/transparent_image.dart';

class ListGameWidget extends StatelessWidget {
  final Game game;
  final bool isSmall;
  const ListGameWidget({Key? key, required this.game, required this.isSmall}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    var title =  Text(
      game.name,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );

    var developer = Text(
      game.developer(),
      style: const TextStyle(color: Colors.deepOrangeAccent),
    );

    var imageDimensions = (isSmall)? 125.0 : 100.0;


    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: (isSmall)? MainAxisSize.min : MainAxisSize.max,

          children: [
              Column(
                children: [
                  Center(
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage((game.imageId == null)? "https://" :  "https:${game.image}"),
                        width: imageDimensions,
                        height: imageDimensions,
                        fit: BoxFit.contain,
                    ),
                  ),
                  if(isSmall) title,
                ],
              ),
              if(!isSmall) //Content for larger widget
              Expanded(
                child: Column(
                  children: [
                    title,
                    developer,
                    Wrap(
                      children: game.tags().map((tag) => Card(
                        child:  Padding (
                          padding: const EdgeInsets.all(3),
                          child: Text(tag),
                          ),
                        ),
                      ).take(5).toList(), //Tags go here
                    ),
                  ],
                ),
              ),
          ],
        )
      )
    );
  }
}