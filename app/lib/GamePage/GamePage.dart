import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';


var game =     {
        "id": 20,
        "age_ratings": [
            {
                "id": 344,
                "category": 1,
                "rating": 11
            },
            {
                "id": 43418,
                "category": 2,
                "rating": 5
            },
            {
                "id": 80299,
                "category": 5,
                "rating": 26
            },
            {
                "id": 89423,
                "category": 3,
                "rating": 16
            },
            {
                "id": 110368,
                "category": 7,
                "rating": 37
            },
            {
                "id": 125599,
                "category": 5,
                "rating": 25
            }
        ],
        "aggregated_rating": 92.625,
        "cover": {
            "id": 122598,
            "url": "//images.igdb.com/igdb/image/upload/t_thumb/co2mli.jpg"
        },
        "first_release_date": 1187654400,
        "genres": [
            {
                "id": 5,
                "name": "Shooter"
            },
            {
                "id": 12,
                "name": "Role-playing (RPG)"
            },
            {
                "id": 31,
                "name": "Adventure"
            }
        ],
        "involved_companies": [
            {
                "id": 91804,
                "company": {
                    "id": 13,
                    "name": "Demiurge Studios"
                },
                "developer": false
            },
            {
                "id": 184941,
                "company": {
                    "id": 8,
                    "name": "2K Games"
                },
                "developer": false
            },
            {
                "id": 184942,
                "company": {
                    "id": 2492,
                    "name": "2K Australia"
                },
                "developer": true
            },
            {
                "id": 184943,
                "company": {
                    "id": 649,
                    "name": "2K Boston"
                },
                "developer": true
            },
            {
                "id": 184944,
                "company": {
                    "id": 411,
                    "name": "Robosoft Technologies"
                },
                "developer": false
            }
        ],
        "name": "BioShock",
        "platforms": [
            {
                "id": 6,
                "abbreviation": "PC",
                "name": "PC (Microsoft Windows)"
            },
            {
                "id": 9,
                "abbreviation": "PS3",
                "name": "PlayStation 3"
            },
            {
                "id": 12,
                "abbreviation": "X360",
                "name": "Xbox 360"
            },
            {
                "id": 14,
                "abbreviation": "Mac",
                "name": "Mac"
            }
        ],
        "summary": "BioShock is a horror-themed first-person shooter set in a steampunk underwater dystopia. The player is urged to turn everything into a weapon: biologically modifying their own body with Plasmids, hacking devices and systems, upgrading their weapons, crafting new ammo variants, and experimenting with different battle techniques are all possible. The game is described by the developers as a spiritual successor to their previous PC title System Shock 2. BioShock received high praise in critical reviews for its atmospheric audio and visual quality, absorbing and original plot and its unique gaming experience."
    };

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePage();
}


class _GamePage extends State<GamePage>{
  bool addButVis = false;
  int releaseDate = int.parse(game["first_release_date"].toString());
  var temp = game["involved_companies"];
  //String devName = temp!=null?temp[0]["company"]["name"] : "<developer>";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F0CC),
      appBar: AppBar(
        title: const Text(
          "Game Page",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: 
        SingleChildScrollView(
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ 
                Stack(
                  children: <Widget>[
                    SizedBox(
                            height: (MediaQuery.of(context).size.height / 5),
                            child: Container(
                                color: Colors.blueAccent,
                                //color: Color(0xFFCE9164),//remove color to make it transpatrent
                                child: const Center(child: Text(""))),
                          ),
                    Row(
                      children: [
                        SizedBox(width:25,height: MediaQuery.of(context).size.height / 5,),
                        Container(
                          width: 100,
                          height: 125,
                          //color: Colors.blueAccent,
                          color: Color(0xFFEC4686),
                          child://Image.asset('assets/cover.jpg'),
                          const Text('<Cover>', textAlign: TextAlign.center),
                        ),
                        const SizedBox(width:5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height:5),
                            Text((game["name"]!=null?game["name"].toString():'Title'), textAlign: TextAlign.center),
                            const SizedBox(height:5),
                            Text(DateTime.fromMicrosecondsSinceEpoch(releaseDate*1000000).toString(), textAlign: TextAlign.center),
                            const SizedBox(height:65),
                            const Text("Demiurge Studios", textAlign: TextAlign.center),
                        ],),
                      ],
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [ 
                    const SizedBox(height:15),
                    Row(children: [const SizedBox(width:10),const Text('Adventure Horror', textAlign: TextAlign.center),],),
                    const SizedBox(height:5),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                        const SizedBox(width:10),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                                    height: MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/3),
                                    child: Container(
                                        color: Colors.blueAccent,
                                        //color: Color(0xFFEFB255),//remove color to make it transpatrent
                                        child: Text(game["summary"]!=null?game["summary"].toString():'Description')),
                                  ),
                          ],
                        ),
                        const SizedBox(width:15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              color: Colors.blueAccent,
                              //color: Color(0xFFEFB255),
                              child: Center(child: Text("Review Score:\n"+ (game["aggregated_rating"]!=null?game["aggregated_rating"].toString():'<Ratings>'))),
                            ),
                            SizedBox(height:(MediaQuery.of(context).size.height / 2) - 300),
                            Container(
                              width: 100,
                              height: 150,
                              color: Colors.blueAccent,
                              //color: Color(0xFFEFB255),
                              child:const Center(child: Text("Age Ratings: \n16")),
                            ),              
                        ],) 
                      ],
                    ),         
                    const SizedBox(height:5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(width:200,
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: 
                          Wrap(
                            children: [
                                  const Text('Shooter', textAlign: TextAlign.center),
                                  const Text('Role-playing (RPG)', textAlign: TextAlign.center),
                                  const Text('Adventure', textAlign: TextAlign.center),                
                            ],
                          ) ,
                        ),
                        const SizedBox(height:5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                                const SizedBox(width:10),
                                const Text('Single Player', textAlign: TextAlign.center),              
                        ],),
                        const SizedBox(height:5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                                const SizedBox(width:65),
                                const Text('Single Player', textAlign: TextAlign.center),              
                        ],),
                      ],),
                      SizedBox(width: 25,),
                      if(addButVis)Column(
                        children: [
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Playing"),)),
                          const SizedBox(height:5),
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Ongoing"),)),
                          const SizedBox(height:5),
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Backlog"),)),                        
                        ],)
                      else
                        Column(
                        children: [SizedBox(height:20,width:75),],)
                      ,
                      ElevatedButton(
                        onPressed: (){
                          if(addButVis){
                            addButVis=false;
                            setState(() {});
                          }
                          else{
                            addButVis=true;
                            setState(() {});
                          }
                          // Add your onPressed code here!
                        },
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(24),
                        ),
                      )
                    ],),   
                  ],
                ),
              ],
          ),
        ),
      //   floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if(addButVis){
      //       addButVis=false;
      //       setState(() {});
      //     }
      //     else{
      //       addButVis=true;
      //       setState(() {});
      //     }
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Colors.blueAccent,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}