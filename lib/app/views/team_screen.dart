import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedesk/app/models/poke_list_model.dart';
import 'package:pokedesk/app/models/team_model.dart';
import 'package:pokedesk/app/services/poke_service.dart';
import 'package:pokedesk/app/services/team_service.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key, this.index});
  final int? index;

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  Team team = Team(
      teamName: "",
      pokemonNames: [],
      timeAdd: DateTime.now(),
      timeDelete: null);
  int size = 10;
  bool showList = false;

  final PagingController<int, PokResult> _pagingController =
      PagingController(firstPageKey: 0);
  PokeList pokeList = PokeList(count: 0, results: []);

  TextEditingController teamName = TextEditingController();

  @override
  void initState() {
    teamName.text = team.teamName;
    _pagingController.addPageRequestListener((pageKey) {
      getPokeList(pageKey);
    });

    super.initState();
  }

  void getPokeList(int pageKey) async {
    try {
      final data = await PokeService.list(offset: pageKey);
      pokeList.count = data.count;
      final isLastPage = data.results.length < size;
      if (isLastPage) {
        _pagingController.appendLastPage(data.results);
      } else {
        final nextPageKey = pageKey + data.results.length;
        _pagingController.appendPage(data.results, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  void add(String name) {
    if (team.pokemonNames.contains(name)) {
      EasyLoading.showError('Pokemon ซ้ำ');
    } else if (team.pokemonNames.length >= 6) {
      EasyLoading.showError('Pokemon เกิน 6 ตัว');
    } else {
      setState(() {
        team.pokemonNames.add(name);
      });
    }
  }

  void remove(index) {
    setState(() {
      team.pokemonNames.removeAt(index);
    });
  }

  void save() async {
    teamService.teamData.teams.add(team..teamName=teamName.text);
    await teamService.put();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สร้างทีม"),
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    showList = !showList;
                  }),
              icon: const Icon(Icons.list)),
          IconButton(onPressed: () => save(), icon: const Icon(Icons.save)),
        ],
      ),
      body: Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: teamName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อทีม',
              ),
            ),
          ),
          Container(
            height: 310,
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: List.generate(team.pokemonNames.length, (index) {
                String data = team.pokemonNames[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data),
                    IconButton(
                      onPressed: () {
                        remove(index);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                );
              }),
            ),
          ),
          if (showList)
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 205, 221, 249),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PagedListView(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<PokResult>(
                        itemBuilder: (context, item, index) => SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name),
                                IconButton(
                                    onPressed: () => add(item.name),
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ))
                              ],
                            )),
                      )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
