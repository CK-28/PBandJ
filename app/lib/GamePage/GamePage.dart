import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import 'package:transparent_image/transparent_image.dart';

List<Game> games = gamesParser();

Game thisGame = games[3];
List<String> tags = thisGame.tags();

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePage();
}


class _GamePage extends State<GamePage>{
  bool addButVis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFFCE9164),
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
                            height: (MediaQuery.of(context).size.height / 4),
                            child: Container(
                                //color: Colors.blueAccent,
                                color:  Color(0xFFEC4686),//remove color to make it transpatrent
                                child: const Center(child: Text(""))),
                          ),
                    Row(
                      children: [
                        SizedBox(width:25,height: MediaQuery.of(context).size.height / 4,),
                        Container(
                          width: 125,
                          height: 150,
                          //color: Colors.blueAccent,
                          color: Color(0xFFEC4686),
                          child:FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage((thisGame.image == null)? "https://" : "https:${thisGame.image}"),
                                  width: 100,
                                  height: 125,
                                  fit: BoxFit.contain,
                              )                          //const Text('<Cover>', textAlign: TextAlign.center),
                        ),
                        const SizedBox(width:5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height:5),
                            Text(thisGame.name, textAlign: TextAlign.center),
                            const SizedBox(height:5),
                            Text(thisGame.release.toString(), textAlign: TextAlign.center),
                            const SizedBox(height:65),
                            Text(thisGame.developer(), textAlign: TextAlign.center),
                        ],),
                      ],
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [ 
                    const SizedBox(height:15),
                    Row(children: [const SizedBox(width:10), Text(thisGame.genres[0].name, textAlign: TextAlign.center),],),
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
                              child:Center(child: Text("Age Rating: " + thisGame.stringAgeRating())),
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
                          Container(width:200,height: 50,
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                            child:
                              Wrap(
                                children: [
                                        for(String t in tags)
                                          Container(padding: EdgeInsets.all(5),child: Text(t, textAlign: TextAlign.center)),               
                                ],
                              ) ,
                          ),
                          SizedBox(height: tags.length!=null? tags.length.toInt()*4 : 75),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center ,
                            children: [
                                  const SizedBox(width:10),
                                  const Text('<Gamemode>', textAlign: TextAlign.center),              
                          ],),
                          const SizedBox(height:5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                            children: [
                                  const SizedBox(width:65),
                                  const Text('<GamemodeList>', textAlign: TextAlign.center),              
                          ],),
                      ],),
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
                        },
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCE9164),
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
    );
  }
}