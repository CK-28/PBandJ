import 'package:flutter/material.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';
import 'GameGrid.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class HomePage extends StatelessWidget {
  List<Game> games = gamesParser();

  // get game lists from databse
  // db.collection(users).doc(auth.user.id).collection("playing").get() or someting (to get whole collection)
  // might return Map
  // might need new version of gamesParser to parse map (very unlikely, especially if we do the below)
  // iterate through data from .get() and add to list
  // then call gamesParser on list

  // look at software design
  // onSnapshot to live update
  // userQuery = .get, which gets all user collection data, then  gets data for each thing and create new list
  // run games through gamesParser

  Future<List<Game>> getList(String list) async {
    List<Game> result = [];

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize database instance
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      Stream collectionStream = FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection(list).snapshots();

      
        // QuerySnapshot querySnapshot = await db.collection("users").doc(currentUser.uid).collection(list).get();

        // Map<String, dynamic> result ;
        // querySnapshot.docs.forEach((doc) {
        //   print(doc);
        //   // result.add(Game.fromJson(doc));
        // });
    }     
    return result;
  }

  void buildList() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF8D5BC),
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
            GameGrid(
                heading: "Playing",
                games: games,
            ),
            GameGrid(
                heading: "Backlog",
                games: games,
            ),
            GameGrid(
                heading: "Ongoing",
                games: games,
            ),
            // ElevatedButton(onPressed: () {
            //    getList("playing");
            // }, 
            // child: Text("ClickMe"))
        ]
      )
    );
  }
}