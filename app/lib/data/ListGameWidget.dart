
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
      style: const TextStyle(color: Colors.black, fontSize: 25),
    );

    var developer = Text(
      game.developer(),
      style: const TextStyle(color: Colors.black),
    );

    var gameRating = Text(
      "Age Rating: " + game.stringAgeRating(),
      style: TextStyle(color: Colors.black),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ]
          ),
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
                            image: NetworkImage((game.imageId == null || game.imageId!.isEmpty)?
                            "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png":
                            game.getImageFromId("1080p")),
                            imageErrorBuilder:(context, exception, stackTrace) {
                              return const Text("Image error");
                            },
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
                            color: Color(0xFF9CEAEF),
                            child:  Padding (
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                              child: Text(tag, style: TextStyle(color: Colors.black)),
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
        )
      ),
    );
  }
}