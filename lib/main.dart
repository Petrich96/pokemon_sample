import 'dart:io';
import 'package:path_provider/path_provider.dart'  as pathprovider;
import 'package:flutter/material.dart';
import 'package:pokemon/MainScreen.dart';
import 'pokemon.dart';
import 'pokemon_repository.dart';
import 'PokemonDetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
var path = await pathprovider.getApplicationDocumentsDirectory();
print(path.path);
  Hive.init(path.path);
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
