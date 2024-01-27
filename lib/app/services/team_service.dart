import 'package:pokedesk/app/models/team_model.dart';
import 'package:pokedesk/app/services/hive_service.dart';

TeamService teamService = TeamService();

class TeamService {
  TeamData teamData = TeamData(teams: []);
  getTeam() async {
    var data = await HiveService.get("team");
    print("dataxxxx ${ data.runtimeType }");
    if (data != null) {
      teamData = TeamData.fromJson(data);
    } else {
      put();
    }
  }

  put() async {
    await HiveService.put(key: "team", data: teamData.toJson());
  }
}
