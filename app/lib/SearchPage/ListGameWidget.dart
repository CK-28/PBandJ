import 'package:app/GamePage/GamePage.dart';
import 'package:flutter/material.dart';
import 'package:app/data/Game.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ListGameWidget extends StatelessWidget {
  final Game game;
  final bool isSmall;
  const ListGameWidget({Key? key, required this.game, required this.isSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = Text(
      game.name,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 25),
    );

    var developer = Text(
      game.developer(),
    );

    var gameRating = Text(
      "Age Rating: " + game.stringAgeRating(),
    );

    var platformText = Text(
      "Platforms: ${game.platformList().take(5).join(", ")}",
    );

    var imageDimensions = (isSmall) ? 150.0 : 125.0;

    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GamePage(game: game)))
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              decoration: BoxDecoration(
                  color:
                      Provider.of<ThemeProvider>(context).themeData.cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ]),
              child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisSize:
                        (isSmall) ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage((game.imageId == null ||
                                      game.imageId!.isEmpty)
                                  ? "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png"
                                  : game.getImageFromId("1080p")),
                              imageErrorBuilder:
                                  (context, exception, stackTrace) {
                                return const Text("Image error");
                              },
                              width: imageDimensions,
                              height: imageDimensions,
                              fit: BoxFit.contain,
                            ),
                          ),
                          if (isSmall) title,
                        ],
                      ),
                      if (!isSmall) //Content for larger widget
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              title,
                              developer,
                              gameRating,
                              platformText,
                              Wrap(
                                children: game
                                    .genreList()
                                    .map(
                                      (tag) => Card(
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                .themeData
                                                .primaryColorLight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          child: Text(tag,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    )
                                    .take(5)
                                    .toList(), //Tags go here
                              ),
                            ],
                          ),
                        ),
                    ],
                  )))),
    );
  }
}
