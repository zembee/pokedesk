// To parse this JSON data, do
//
//     final pokeData = pokeDataFromJson(jsonString);

import 'dart:convert';

PokeData pokeDataFromJson(Map<String, dynamic> data) => PokeData.fromJson(data);

String pokeDataToJson(PokeData data) => json.encode(data.toJson());

class PokeData {
  List<Ability> abilities;
  int baseExperience;
  List<Form> forms;
  int height;
  int id;
  String locationAreaEncounters;
  String name;
  int order;
  Sprites sprites;
  List<Type> types;
  int weight;

  PokeData({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.height,
    required this.id,
    required this.locationAreaEncounters,
    required this.name,
    required this.order,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory PokeData.fromJson(Map<String, dynamic> json) => PokeData(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        forms: List<Form>.from(json["forms"].map((x) => Form.fromJson(x))),
        height: json["height"],
        id: json["id"],
        locationAreaEncounters: json["location_area_encounters"],
        name: json["name"],
        order: json["order"],
        sprites: Sprites.fromJson(json["sprites"]),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "height": height,
        "id": id,
        "location_area_encounters": locationAreaEncounters,
        "name": name,
        "order": order,
        "sprites": sprites.toJson(),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Ability {
  Form ability;
  bool isHidden;
  int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Form.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class Form {
  String name;
  String url;

  Form({
    required this.name,
    required this.url,
  });

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Sprites {
  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;
  Other other;

  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    required this.other,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
        other: Other.fromJson(json["other"]),
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        "other": other.toJson(),
      };
}

class Other {
  Home home;

  Other({
    required this.home,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        home: Home.fromJson(json["home"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
      };
}

class Home {
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class Type {
  int slot;
  Form type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Form.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}
