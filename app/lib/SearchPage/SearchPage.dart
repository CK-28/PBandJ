
import 'package:app/SearchPage/SearchFieldWidget.dart';
import 'package:app/SearchPage/SearchGamesListWidget.dart';
import 'package:app/State/ReduxStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../data/Game.dart';
import '../data/GamesParser.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  // Future<List<Game>> games = gamesParser();

  @override
  Widget build(BuildContext context) {
    return  StoreConnector<AppState, Future<List<Game>>>(
        converter: (Store<AppState> store) => GameApiParser().searchGames(
            store.state.search,
            store.state.isRestricted,
            store.state.platforms
        ),
        builder: (storeContext, Future<List<Game>> games) {
          return Container(
              color: Color(0xFFF8D5BC),
              child: Column(
                children: [
                  SearchFieldWidget(), //Search section
                  FutureBuilder<List<Game>>(
                      future: games,
                      builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return SearchGamesListWidget(games: snapshot.data!);
                        } else {
                          return const CircularProgressIndicator(color: Colors.red,);
                        }
                      }
                  )
                ],
              )
          );
        },
    );
  }
}