import 'package:flutter/material.dart';
import '../data/Game.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class GamePage extends StatefulWidget {
  final Game game;
  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePage();
}


class _GamePage extends State<GamePage>{
  bool addButVis = false;

  @override
  Widget build(BuildContext context) {
    Game thisGame = widget.game;
    List<String> tags = thisGame.tags();

    DateFormat dateFormat = DateFormat("yyyy/MM/dd");

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF875632),
        title: const Text(
          "Game Page",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: 
      Container(
        color: Color(0xFFF8D5BC),
        child: ListView(
          children:[ 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ 
                Stack(
                  children: <Widget>[
                    SizedBox(
                            height: (MediaQuery.of(context).size.height / 5),
                            child: Container(
                                //color: Colors.blueAccent,
                                color:  Color(0xFFEC4686),//remove color to make it transpatrent
                                child: const Center(child: Text(""))),
                          ),
                    Row(
                      children: [
                        SizedBox(width:25,height: MediaQuery.of(context).size.height / 5,),
                        Container(
                          width: 125,
                          height: 150,
                          //color: Colors.blueAccent,
                          color: Color(0xFFEC4686),
                          child:FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage((thisGame.image == null)? "https://" : thisGame.getImageFromId("1080p")),
                                  width: 100,
                                  height: 125,
                                  fit: BoxFit.contain,
                              )                          //const Text('<Cover>', textAlign: TextAlign.center),
                        ),
                        const SizedBox(width:5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(thisGame.name, style: TextStyle(
                                fontSize: 25
                              )),
                            Text(thisGame.developer()),
                            Text(dateFormat.format(thisGame.release)),
                            Wrap(
                                children: [
                                        for(String t in tags)
                                          Container(padding: EdgeInsets.all(5),child: Text(t, textAlign: TextAlign.center)),               
                                ],
                              ) ,
                            // Flexible(
                            //   flex: 1,
                            //   child: Text(thisGame.name, style: TextStyle(
                            //     fontSize: 25
                            //   )),
                            // ),
                            // Flexible(
                            //   flex: 1,
                            //   child: Text(thisGame.developer()),
                            // ),
                            // Flexible(
                            //   flex: 1,
                            //   child: Text(dateFormat.format(thisGame.release)),
                            // ),
                        ]),
                      ],
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [ 
                    // const SizedBox(height:15),
                    // Row(children: [const SizedBox(width:10), Text(thisGame.genres[0].name, textAlign: TextAlign.center),],),
                    // const SizedBox(height:5),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Description", style: TextStyle(
                        fontSize: 18
                      ))
                    ),
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
                                decoration: const BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFCE9164),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(thisGame.summary)),
                                ),
                          ],
                        ),
                        const SizedBox(width:15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFCE9164),
                              ),
                              padding: EdgeInsets.all(5),
                              width: 100,
                              height: 150,
                              child: Center(child: Text("Review Score:\n"+ thisGame.rating.toString())),
                            ),
                            SizedBox(height:(MediaQuery.of(context).size.height / 2) - 300),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFCE9164),
                              ),                              
                              padding: const EdgeInsets.all(5),
                              width: 100,
                              height: 150,
                              child:Center(child: Text(thisGame.stringAgeRating())),
                            ),              
                        ],) 
                      ],
                    ),         
                    const SizedBox(height:5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(width: 25,),
                      if(addButVis)Column(
                        children: [
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Playing"),style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFCE9164),),)),
                          const SizedBox(height:5),
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Ongoing"),style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFCE9164),),)),
                          const SizedBox(height:5),
                          SizedBox(height:20,width:100,child: ElevatedButton(onPressed: (() {}), child: Text("Backlog"),style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFCE9164),),)),                        
                        ],)
                      else
                        Column(
                          children: [SizedBox(height:20,width:75),],
                        ),
                    ],
                  ),   
                ],
              ),
            ],
          ),
        ]
      ),
      ),
        
      floatingActionButton: ElevatedButton(
        onPressed: (){
          if(addButVis){
            addButVis=false;
            setState(() {});
          }
          else{
            addButVis=true;
            setState(() {});
          }
        },
        child: Icon(Icons.add, color: Colors.black),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF9CEAEF),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24),
        ),
      )
    );
  }
}