import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import '../home/GameGrid.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  List<Game> games = gamesParser();

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildBody(),
          ],
        ),
      ]),
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return (Stack(
      children: <Widget>[
        Container(
          height: (222),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Provider.of<ThemeProvider>(context).themeData.primaryColor,
          ),
        ),
        Row(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1635107510862-53886e926b74?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80"),
                    width: 135,
                  ))),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Test Account", style: TextStyle(fontSize: 25)),
                Text("Total Games: ",
                    style: TextStyle(
                      fontSize: 16,
                      height: 3,
                    )),
                Text("Completed Games: ",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ]),
        ]),
      ],
    ));
  }

  Widget _buildBody() {
    return Container(
        height: 500,
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            children: [
              GameGrid(
                heading: "Playing",
                games: games,
              ),
              GameGrid(
                heading: "Completed",
                games: games,
              ),
            ]));
  }
}
