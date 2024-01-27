import 'package:flutter/material.dart';
import 'package:pokedesk/app/models/team_model.dart';
import 'package:pokedesk/base/utils.dart';

Padding buildTeamItem({required Team teams, required VoidCallback onDelete}) {
  bool isDelete = teams.timeDelete != null;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDelete ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ชื่อทีม : ${teams.teamName}",
                style: const TextStyle(fontSize: 16),
              ),
              if (!isDelete)
                IconButton(
                  onPressed: () => onDelete(),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(teams.pokemonNames.length,
                    (index) => Text(teams.pokemonNames[index])),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CreateAt : ${formattedDate(teams.timeAdd)}",
                style: TextStyle(fontSize: 10),
              ),
              if (isDelete)
                Text(
                  "DeleteAt : ${formattedDate(teams.timeDelete!)}",
                  style: TextStyle(fontSize: 10),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
