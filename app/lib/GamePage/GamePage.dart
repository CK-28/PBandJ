import 'package:flutter/material.dart';
import '../data/Game.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:app/theme/theme_provider.dart';
import './AddButton.dart';

class GamePage extends StatefulWidget {
  final Game game;
  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  bool addButVis = false;

  void _showAction() {}

  @override
  Widget build(BuildContext context) {
    Game thisGame = widget.game;
    List<String> tags = thisGame.tags();

    DateFormat dateFormat = DateFormat("yyyy/MM/dd");

    int _selectedIndex = 0;

    var stringRating =
        (thisGame.rating != null) ? thisGame.rating!.toStringAsFixed(2) : "N/A";

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        /*backgroundColor: Color.fromARGB(255, 255, 255, 255),*/
        appBar: AppBar(
          /*backgroundColor: Color(0xFF875632),*/
          title: Text(
            thisGame.name,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
          /*color: Color(0xFFF8D5BC),*/
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: (222),
                      child: Container(
                        color: Provider.of<ThemeProvider>(context)
                            .themeData
                            .primaryColor, //remove color to make it transpatrent
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                                child: FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage((thisGame.imageId ==
                                              null ||
                                          thisGame.imageId!.isEmpty)
                                      ? "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png"
                                      : thisGame.getImageFromId("1080p")),
                                  width: 135,
                                ))),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(thisGame.name,
                                  style: TextStyle(fontSize: 25)),
                              Text("Developer: " + thisGame.developer(),
                                  style: TextStyle(fontSize: 16)),
                              Text("Release Date: " +
                                  dateFormat.format(thisGame.release)),
                              Text(
                                  "Platforms: ${thisGame.platformList().take(5).join(", ")}"),
                            ])),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Description",
                            style: TextStyle(fontSize: 18))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                                // needs to be an expanded
                                height: 400,
                                width: 275,
                                decoration: BoxDecoration(
                                    color: Provider.of<ThemeProvider>(context)
                                        .themeData
                                        .cardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Text(thisGame.summary))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Provider.of<ThemeProvider>(context)
                                      .themeData
                                      .primaryColorDark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]),
                              padding: EdgeInsets.all(5),
                              width: 100,
                              height: 100,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Review Score:",
                                        textAlign: TextAlign.center),
                                    Text(stringRating,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Provider.of<ThemeProvider>(context)
                                      .themeData
                                      .primaryColorDark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]),
                              padding: const EdgeInsets.all(5),
                              width: 100,
                              height: 100,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Age Rating:",
                                        textAlign: TextAlign.center),
                                    Text(thisGame.stringAgeRating(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 350,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Wrap(
                        children: [
                          for (String t in tags)
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Provider.of<ThemeProvider>(context)
                                          .themeData
                                          .primaryColorLight,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ]),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(t, textAlign: TextAlign.center)),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ),
        floatingActionButton: ExpandableFab(
          distance: 50.0,
          children: [
            ActionButton(
              onPressed: () => _showAction(),
              label: const Text("Playing"),
            ),
            ActionButton(
              onPressed: () => _showAction(),
              label: const Text("Backlog"),
            ),
            ActionButton(
              onPressed: () => _showAction(),
              label: const Text("Ongoing"),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 30,
        ));
  }
}
