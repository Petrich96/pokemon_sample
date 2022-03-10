import 'package:flutter/material.dart';
import 'package:pokemon/PokemonDetailScreen.dart';
import 'package:pokemon/pokemon.dart';
import 'pokemon_repository.dart';
import 'PokemonDetailScreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  bool isList = true;

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isList = !isList;
                });
              },
              child: isList ? Text("Таблица") : Text("Список")),
          Expanded(
            child: isList ? ListPokemon() : GridPokemon(),
          ),
        ],
      ),
    ));
  }
}

class ListPokemon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListPokemonState();
}

class ListPokemonState extends State<ListPokemon> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      if (index == 0) return Container();

      var pokemon =
          Provider.of<PokemonRepo>(context).getPokemonById(index.toString());

      return FutureBuilder(
        future: pokemon,
        builder: (_, asyncSnapshot) => (asyncSnapshot.hasData)
            ? Card(
                child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(PokeDetailScreen.routeName, arguments: index);
                },
                leading: Image.network(
                    (asyncSnapshot.data as Pokemon).sprites!.frontDefault!),
                title: Text("${(asyncSnapshot.data as Pokemon).name}"),
              ))
            : Card(
                child: Center(child: CircularProgressIndicator()),
              ),
      );
    });
  }
}

class GridPokemon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GridPokemonState();
}

class GridPokemonState extends State<GridPokemon> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          index++;
          var pokemon = Provider.of<PokemonRepo>(context)
              .getPokemonById(index.toString());

          return FutureBuilder(
            future: pokemon,
            builder: (context, asyncSnapshot) => (asyncSnapshot.hasData)
                ? Card(
                    elevation: 3,
                    child: GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) => Scaffold(
                              body: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                        tag: 'id$index',
                                        child: Image.network(
                                          (asyncSnapshot.data as Pokemon)
                                              .sprites!
                                              .frontDefault!,
                                        )),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Name: ${(asyncSnapshot.data as Pokemon).name}" ),
                                            Text("Height: ${(asyncSnapshot.data as Pokemon).height}"),
                                            Text("Weigth: ${(asyncSnapshot.data as Pokemon).weight}"),
                                            Text("Base expiriense: ${(asyncSnapshot.data as Pokemon).baseExperience}"),
                                            Text("Abilities: ${(asyncSnapshot.data as Pokemon).abilities!.join(", ")}")
                                          ],
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                        child: Hero(
                          tag: "id$index",
                          child: Image.network((asyncSnapshot.data as Pokemon)
                              .sprites!
                              .frontDefault!),
                        ),
                      ),
                      footer: Center(
                          child:
                              Text("${(asyncSnapshot.data as Pokemon).name}")),
                    ))
                : Card(
                    child: Center(child: CircularProgressIndicator()),
                  ),
          );
        });
  }
}
