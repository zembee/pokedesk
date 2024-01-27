// To parse this JSON data, do
//
//     final teamData = teamDataFromJson(jsonString);

import 'dart:convert';


String teamDataToJson(TeamData data) => json.encode(data.toJson());

class TeamData {
    List<Team> teams;

    TeamData({
        required this.teams,
    });

    factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
    };
}

class Team {
    String teamName;
    List<String> pokemonNames;
    DateTime timeAdd;
    DateTime? timeDelete;

    Team({
        required this.teamName,
        required this.pokemonNames,
        required this.timeAdd,
        required this.timeDelete,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamName: json["teamName"],
        pokemonNames: List<String>.from(json["pokemonNames"].map((x) => x)),
        timeAdd: DateTime.parse(json["timeAdd"]),
        timeDelete: DateTime.tryParse(json["timeDelete"]??""),
    );

    Map<String, dynamic> toJson() => {
        "teamName": teamName,
        "pokemonNames": List<dynamic>.from(pokemonNames.map((x) => x)),
        "timeAdd": timeAdd,
        "timeDelete": timeDelete,
    };
}
