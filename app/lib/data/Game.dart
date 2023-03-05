

class Game {
  final int id;
  final String name;
  final double? rating;
  final int ageRating; //need parsed to a string of which rating but will do later
  final String? image;
  final String summary;
  final DateTime release;
  final List<Genre> genres;
  final List<Company> companies;
  final List<Platform> platforms;

  Game({
    required this.id,
    required this.name,
    required this.image,
    required this.ageRating,
    required this.rating,
    required this.summary,
    required this.release,
    required this.genres,
    required this.companies,
    required this.platforms,
  });

  factory Game.fromJson(Map<String, dynamic> json) {

    var genres = List<Genre>.from(json["genres"].map((genre) => Genre.fromJson(genre)));
    var companies = List<Company>.from(json["involved_companies"].map((company) => Company.fromJson(company)));
    var ageRating = json["age_ratings"]
        .where((areaRating) => (areaRating["category"] == 1))
        .toList().first["rating"];
    var platforms = List<Platform>.from(json["platforms"].map((platform) => Platform.fromJson(platform)));

    return Game(
        id: json['id'],
        name: json["name"],
        image: json["cover"]["url"],
        summary: json["summary"],
        rating: json["aggregated_rating"],
        ageRating: ageRating,
        release: DateTime.fromMillisecondsSinceEpoch(json["first_release_date"]),
        genres: genres,
        companies: companies,
        platforms: platforms,
    );
  }

}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json["id"], name: json["name"]);
  }

}

class Company {
  final int id;
  final String name;
  final bool developer;

  Company({required this.id, required this.name, required this.developer});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json["company"]["id"],
        name: json["company"]["name"],
        developer: json["developer"]
    );
  }
}

class Platform {
  final int id;
  final String? abbr;
  final String name;

  Platform({required this.id, required this.name, required this.abbr});

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
        id: json["id"],
        name: json["name"],
        abbr: json["abbreviation"],
    );
  }
}


// class Game {
//   int? id;
//   List<AgeRatings>? ageRatings;
//   double? aggregatedRating;
//   Cover? cover;
//   int? firstReleaseDate;
//   List<Genres>? genres;
//   List<InvolvedCompanies>? involvedCompanies;
//   String? name;
//   List<Platforms>? platforms;
//   String? summary;
//
//   Game(
//       {this.id,
//         this.ageRatings,
//         this.aggregatedRating,
//         this.cover,
//         this.firstReleaseDate,
//         this.genres,
//         this.involvedCompanies,
//         this.name,
//         this.platforms,
//         this.summary});
//
//   Game.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['age_ratings'] != null) {
//       ageRatings = <AgeRatings>[];
//       json['age_ratings'].forEach((v) {
//         ageRatings!.add(new AgeRatings.fromJson(v));
//       });
//     }
//     aggregatedRating = json['aggregated_rating'];
//     cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
//     firstReleaseDate = json['first_release_date'];
//     if (json['genres'] != null) {
//       genres = <Genres>[];
//       json['genres'].forEach((v) {
//         genres!.add(new Genres.fromJson(v));
//       });
//     }
//     if (json['involved_companies'] != null) {
//       involvedCompanies = <InvolvedCompanies>[];
//       json['involved_companies'].forEach((v) {
//         involvedCompanies!.add(new InvolvedCompanies.fromJson(v));
//       });
//     }
//     name = json['name'];
//     if (json['platforms'] != null) {
//       platforms = <Platforms>[];
//       json['platforms'].forEach((v) {
//         platforms!.add(new Platforms.fromJson(v));
//       });
//     }
//     summary = json['summary'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.ageRatings != null) {
//       data['age_ratings'] = this.ageRatings!.map((v) => v.toJson()).toList();
//     }
//     data['aggregated_rating'] = this.aggregatedRating;
//     if (this.cover != null) {
//       data['cover'] = this.cover!.toJson();
//     }
//     data['first_release_date'] = this.firstReleaseDate;
//     if (this.genres != null) {
//       data['genres'] = this.genres!.map((v) => v.toJson()).toList();
//     }
//     if (this.involvedCompanies != null) {
//       data['involved_companies'] =
//           this.involvedCompanies!.map((v) => v.toJson()).toList();
//     }
//     data['name'] = this.name;
//     if (this.platforms != null) {
//       data['platforms'] = this.platforms!.map((v) => v.toJson()).toList();
//     }
//     data['summary'] = this.summary;
//     return data;
//   }
// }
//
// class AgeRatings {
//   int? id;
//   int? category;
//   int? rating;
//
//   AgeRatings({this.id, this.category, this.rating});
//
//   AgeRatings.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     category = json['category'];
//     rating = json['rating'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category'] = this.category;
//     data['rating'] = this.rating;
//     return data;
//   }
// }
//
// class Cover {
//   int? id;
//   String? url;
//
//   Cover({this.id, this.url});
//
//   Cover.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     return data;
//   }
// }
//
// class Genres {
//   int? id;
//   String? name;
//
//   Genres({this.id, this.name});
//
//   Genres.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class InvolvedCompanies {
//   int? id;
//   Genres? company;
//   bool? developer;
//
//   InvolvedCompanies({this.id, this.company, this.developer});
//
//   InvolvedCompanies.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     company =
//     json['company'] != null ? new Genres.fromJson(json['company']) : null;
//     developer = json['developer'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.company != null) {
//       data['company'] = this.company!.toJson();
//     }
//     data['developer'] = this.developer;
//     return data;
//   }
// }
//
// class Platforms {
//   int? id;
//   String? abbreviation;
//   String? name;
//
//   Platforms({this.id, this.abbreviation, this.name});
//
//   Platforms.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     abbreviation = json['abbreviation'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['abbreviation'] = this.abbreviation;
//     data['name'] = this.name;
//     return data;
//   }
// }
