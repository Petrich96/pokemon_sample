import 'package:flutter/material.dart';
import 'package:pokemon/MainScreen.dart';
import 'pokemon.dart';
import 'pokemon_repository.dart';
import 'PokemonDetailScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

PokemonRepo Poke_repo = PokemonRepo();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonRepo(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          PokeDetailScreen.routeName: (_) => PokeDetailScreen(),
        },
        home: MainScreen(),
      ),
    );
  }
}
