import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedesk/app/models/poke_list_model.dart';
import 'package:pokedesk/app/services/poke_service.dart';
import 'package:pokedesk/app/views/pokemon.dart';
import 'package:pokedesk/app/views/team_setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int size = 10;

  final PagingController<int, PokResult> _pagingController =
      PagingController(firstPageKey: 0);
  PokeList pokeList = PokeList(count: 0, results: []);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetch(pageKey);
    });

    super.initState();
  }

  void openTeamSetting() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TeamSettingScreen(),
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void fetch(int pageKey) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PokeDesk"), actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              child: const Text("จัดการทีม"),
              onPressed: () {
                openTeamSetting();
              },
            ))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedListView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<PokResult>(
              itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pokemon(name: item.name),
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 60,
                        child: Text(item.name))),
              ),
            )),
      ),
    );
  }
}
