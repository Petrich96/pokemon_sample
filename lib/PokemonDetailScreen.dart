import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'pokemon_repository.dart';
import 'package:provider/provider.dart';

class PokeDetailScreen extends StatefulWidget {
  PokeDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/detail';

  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonID =
        (ModalRoute.of(context)!.settings.arguments as int).toString();

    return FutureBuilder(
        future: Provider.of<PokemonRepo>(context).getPokemonById(pokemonID),
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData)
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          var pokemon = asyncSnapshot.data as Pokemon;
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text(pokemon.name!)),
            ),
            body: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 30,
                    child: InkWell(
                        onTap: () {
                          _gotoDetailsPage(context,  pokemon.sprites!.frontDefault!);
                        },
                        child: Hero(
                            tag: "POKEVIEW",
                            child: Image.network(
                              pokemon.sprites!.frontDefault!,
                            ))),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Name ${pokemon.name}"),
                        Text("Height ${pokemon.height}"),
                        Text("Weigth ${pokemon.weight}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _gotoDetailsPage(BuildContext context, String imageURI) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                  tag: 'POKEVIEW',
                  child: Image.network(
                    imageURI,
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
