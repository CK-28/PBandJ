

class Game {
  final int id;
  final String name;
  final double? rating;
  final int ageRating; //need parsed to a string of which rating but will do later
  final String? image;
  final String? imageId;
  final String summary;
  final DateTime release;
  final List<Genre> genres;
  final List<Company> companies;
  final List<Platform> platforms;

  Game({
    required this.id,
    required this.name,
    required this.image,
    required this.imageId,
    required this.ageRating,
    required this.rating,
    required this.summary,
    required this.release,
    required this.genres,
    required this.companies,
    required this.platforms,
  });


  /**
   * sizes are as follows:
   *
   * cover_small
   * screenshot_med
   * cover_big
   * logo_mid
   * screenshot_big
   * screenshot_huge
   * thumb
   * micro
   * 720p
   * 1080p
   *
   *
   *
   */
  String getImageFromId(String size) {
    return "http://images.igdb.com/igdb/image/upload/t_$size/$imageId.jpg";
  }

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
        imageId: json["cover"]["image_id"],
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
