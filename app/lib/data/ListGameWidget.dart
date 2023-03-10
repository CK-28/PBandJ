
import 'package:app/GamePage/GamePage.dart';
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
      style: const TextStyle(color: Colors.white, fontSize: 25),
    );

    var developer = Text(
      game.developer(),
      style: const TextStyle(color: Colors.deepOrangeAccent),
    );

    var gameRating = Text(
      game.stringAgeRating(),
      style: TextStyle(color: Colors.grey[50]),
    );

    var platformText = Text(
      "Platforms: ${game.platformList().take(5).join(", ")}",
      style: TextStyle(color: Colors.black),
    );

    var imageDimensions = (isSmall)? 150.0 : 125.0;


    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GamePage(game: game))
        )
      },
      child: Card(
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only( top: 8, right: 8, bottom: 8),
          child: Row(
            mainAxisSize: (isSmall)? MainAxisSize.min : MainAxisSize.max,

            children: [
                Column(
                  children: [
                    Center(
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage((game.imageId == null)? "https://" :  game.getImageFromId("1080p")),
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
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title,
                      developer,
                      gameRating,
                      platformText,
                      Wrap(
                        children: game.genreList().map((tag) => Card(
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
      ),
    );
  }
}