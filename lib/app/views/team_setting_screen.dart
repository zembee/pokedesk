import 'package:flutter/material.dart';
import 'package:pokedesk/app/component/team_item.dart';
import 'package:pokedesk/app/models/team_model.dart';
import 'package:pokedesk/app/services/team_service.dart';
import 'package:pokedesk/app/views/team_screen.dart';

class TeamSettingScreen extends StatefulWidget {
  const TeamSettingScreen({super.key});

  @override
  State<TeamSettingScreen> createState() => _TeamSettingScreenState();
}

class _TeamSettingScreenState extends State<TeamSettingScreen> {
  bool isShowHistory = false;
  getData() async {
    print("getData ");
    await teamService.getTeam();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  onDelete(int index) async {
    teamService.teamData.teams[index].timeDelete = DateTime.now();
    await teamService.put();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isShowHistory = !isShowHistory;
                });
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            teamService.teamData.teams.length,
            (index) {
              Team teams = teamService.teamData.teams[index];
              if (isShowHistory) {
                return buildTeamItem(
                  teams: teams,
                  onDelete: () => onDelete(index),
                );
              } else {
                return teams.timeDelete == null
                    ? buildTeamItem(
                        teams: teams,
                        onDelete: () => onDelete(index),
                      )
                    : Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TeamScreen(),
            ),
          );
          getData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
