import 'package:flutter/material.dart';
import 'package:pokedesk/app/models/poke_data_model.dart';
import 'package:pokedesk/app/services/poke_service.dart';
import 'package:pokedesk/base/type_colors.dart';

class Pokemon extends StatefulWidget {
  const Pokemon({super.key, required this.name});
  final String name;

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  Future<PokeData> fetch() async {
    return await PokeService.pokemon(name: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PokeData pokeData = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('#${pokeData.id.toString().padLeft(4, "0")}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("height : ${pokeData.height}"),
                            Text("weight : ${pokeData.weight}"),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Image.network(
                          pokeData.sprites.other.home.frontDefault)),
                  Expanded(
                      child: Column(
                    children: [
                      const Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (Type type in pokeData.types)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: colorsType[type.type.name],
                                  child: Text(type.type.name)),
                            )
                        ],
                      )
                    ],
                  ))
                ],
              );
            } else {
              return const Text("Loading");
            }
          },
        ),
      ),
    );
  }
}
