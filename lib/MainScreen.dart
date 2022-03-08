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
        body: SafeArea(child: ListPokemon()

            // Column(
            //   children: [
            //     ElevatedButton(
            //         onPressed: () {
            //           setState(() {
            //             isList = !isList;
            //           });
            //         },
            //         child: isList ? Text("Таблица") : Text("Список")),
            //     GridPokemon(),
            //     // isList ? ListPokemon() : GridPokemon(),
            //   ],
            // ),
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
      if(index == 0) return Container();

      var pokemon = Provider.of<PokemonRepo>(context).getPokemonById(index.toString());

      return FutureBuilder(
        future: pokemon,
        builder:(_,asyncSnapshot) => (asyncSnapshot.hasData) ? Card(
                child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(PokeDetailScreen.routeName, arguments: index);
                },
                leading: Image.network((asyncSnapshot.data as Pokemon).sprites!.frontDefault!) ,title: Text("${(asyncSnapshot.data as Pokemon).name}"),
              )) : Card(child: Center(child: CircularProgressIndicator()),),
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
    return ListView.builder(
        itemBuilder: (context, index) => Container(
              color: Colors.black,
            ));
  }
}
