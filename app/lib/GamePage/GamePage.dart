import 'package:flutter/material.dart';
import '../data/Game.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import './AddButton.dart';

class GamePage extends StatefulWidget {
  final Game game;
  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePage();
}

class _GamePage extends State<GamePage>{
  bool addButVis = false;

  void _showAction() {

  }

  @override
  Widget build(BuildContext context) {
    Game thisGame = widget.game;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF875632),
        title: Text(
          thisGame.name,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _buildGamePage(thisGame),
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
        color: Color(0xFFEC4686)
      )
    );
  }

  Widget _buildGamePage(Game thisGame) {
    return (
      Container(
        color: Color(0xFFF8D5BC),
        child: ListView(
          children:[ 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ 
                _buildHeader(thisGame),
                _buildBody(thisGame)
              ],
            ),
          ]
        ),
      )
    );
  }

  Widget _buildHeader(Game thisGame) {
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");

    return (Stack(
        children: <Widget>[
          Container(
            height: (222),
            child: Container(
              color: Color(0xFFEC4686),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    ),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage((thisGame.imageId == null || thisGame.imageId!.isEmpty)?
                    "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png":
                    thisGame.getImageFromId("1080p")),
                      width: 135,
                  )
                )
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thisGame.name, style: TextStyle(
                      fontSize: 25
                    )),
                    Text("Developer: " + thisGame.developer(), style: TextStyle(
                      fontSize: 16
                    )),
                    Text("Release Date: " + dateFormat.format(thisGame.release)),
                    Text("Platforms: ${thisGame.platformList().take(5).join(", ")}"),
                  ]
                )
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildDescription(Game thisGame) {
    return(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text("Description", style: TextStyle(
              fontSize: 18
            ))
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container( // needs to be an expanded
              height: 400,
              width: 275,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ]
              ),
              padding: EdgeInsets.all(10),
              child: Text(thisGame.summary)
            )
          ),
        ]
      )
    );
  }

  Widget _buildRatings(Game thisGame) {
    var stringRating = (thisGame.rating != null) ? thisGame.rating!.toStringAsFixed(2): "N/A";

    return (
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color(0xFFCE9164),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ]
              ),
              padding: EdgeInsets.all(5),
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Review Score:", textAlign: TextAlign.center),
                  Text(stringRating, textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ))
                ]
              ),
            ),
            SizedBox(height:30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color(0xFFCE9164),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ]
              ),                              
              padding: const EdgeInsets.all(5),
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Age Rating:", textAlign: TextAlign.center),
                  Text(thisGame.stringAgeRating(), textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ))
                ]
              ),
            ),              
          ],
        )
      )
    );
  }

  Widget _buildTags(Game thisGame) {
    List<String> tags = thisGame.tags();

    return(
      Container(
        width: 350,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Wrap( 
          children: [
            for(String t in tags)
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xFF9CEAEF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ]
                ),       
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(t, textAlign: TextAlign.center)
              ),            
            ),
          ],
        ),       
      )     
    );
  }

  Widget _buildBody(Game thisGame) {
    return (
      Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [ 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDescription(thisGame),
              _buildRatings(thisGame) 
            ],
          ),
          _buildTags(thisGame),             
        ],
      )
    );
  }
}