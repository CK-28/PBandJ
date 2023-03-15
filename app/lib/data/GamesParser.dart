import 'package:app/data/Game.dart';
import 'dart:convert';

import 'package:app/data/data.dart';
import 'package:http/http.dart' as http;

//TODO: remove after migrating all data to remote
List<Game> gamesParser() {
  return List<Game>.from(
    json.decode(jsonString).map((game) => Game.fromJson(game))
  );
}


class GameApiParser {
  //Headers
  final String url = "https://api.igdb.com/v4/games";
  final String authKey = "g1rswu5afmzbzpzdq5r96yktto4bgx";
  final String clientID = "lqiomvwwy2kadxol8y1ghb5swht624";
  //Body

  final List<String> fields = [
    "name", "age_ratings.category", "age_ratings.rating", "aggregated_rating",
    "cover.url", "cover.image_id", "first_release_date", "genres.name",
    "involved_companies.company.name", "involved_companies.developer",
    "summary", "platforms.name", "platforms.abbreviation", "platforms.category",
    "platforms.platform_family.name"
  ];
  final String limit = "limit 100;\n";


  String filterPlatform(List<String> platforms) {
    var filter = "(";

    if(platforms.contains("PC")) {
      filter += "(platforms.category = (4,6))";
      if(platforms.length > 1) {
        filter += " | ";
      }
    }
    List<String> temp = List.of(platforms);
    temp.remove("PC");
    if(temp.isNotEmpty) {
        filter += "(platforms.platform_family.name = (\"${temp.join("\", \"")}\"))";
    }
    filter += ")";
    return filter;
  }


  String filterString (List<String> filter) {
    return "where ${filter.join(" & ")};\n";
  }

  ////
  ////  isRestricted is a value passed in based on if people want to filter out mature titles
  ////  platforms is a list of all platforms to filter with the entries being:
  ////  PlayStation, Xbox, Nintendo, Sega and PC are valid Strings here.
  ////
  List<String> buildFilter (bool isRestricted, List<String> platforms) {
    List<String> filter = <String>[];

    //ESRB Rating
    filter.add("age_ratings.category = 1");

    //filters age rating for mature content
    if (isRestricted) {
      filter.add("age_ratings.rating != (11, 12)");
    }

    //filters platforms that users can filter by
    if(platforms.isNotEmpty) {
      filter.add(filterPlatform(platforms));
    }

    return filter;
  }

  List<Game> gamesParser(String body) {
    return List<Game>.from(
        json.decode(body).map((game) => Game.fromJson(game))
    );
  }

  Future<List<Game>> searchGames(String title, bool isRestricted, List<String> platforms) async {
    final String search = (title.isNotEmpty) ? "search \"$title\";\n": "";

    final String fieldString = "fields ${fields.join(", ")};\n";

    final String filtersString = filterString(buildFilter(isRestricted, platforms));

    String body = fieldString + search + filtersString + limit;

    var res = await http.post(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type' : 'text/plain; charset=UTF-8',
        'Authorization' : 'Bearer $authKey',
        'Client-ID' : clientID,
      },
      body: body,
    );

    if (res.statusCode == 200) {
      return gamesParser(res.body);
    } else {
      throw Exception("Games were not able to be reached");
    }
  }
}