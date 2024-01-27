import 'dart:convert';

PokeList pokeListFromJson(Map<String, dynamic> map) => PokeList.fromJson(map);
String pokeListToJson(PokeList data) => json.encode(data.toJson());

class PokeList {
  int count;
  List<PokResult> results;
  PokeList({
    required this.count,
    required this.results,
  });
  factory PokeList.fromJson(Map<String, dynamic> json) => PokeList(
        count: json["count"],
        results: List<PokResult>.from(
            json["results"].map((x) => PokResult.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PokResult {
  String name;
  String url;
  PokResult({
    required this.name,
    required this.url,
  });
  factory PokResult.fromJson(Map<String, dynamic> json) => PokResult(
        name: json["name"],
        url: json["url"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
