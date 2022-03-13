import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class PokemonRepo extends ChangeNotifier {
  Map<String, Pokemon> pokemons = {};
  Map<String, String> pokemonsName = {};

  //вот локальная база данных вместо Map<String, Pokemon> pokemons = {};
  // var poke = Hive.openBox("pokemons");

  Future<Pokemon> getPokemonById(String id) async {
    // if (pokemons.containsKey(id))
    // return Future.delayed(Duration.zero, () => pokemons[id]!);
    //теперь проверяем наличия JSON в локальной базе
    var poke = await Hive.openBox<String>("pokemons");
    if (poke.containsKey(id))
      return _getPokemonFromStorage(id);
    else
      return this._downloadPokemonInfoById(id);
  }

//появилась новая функция которая достает значение из локальной базы
  Future<Pokemon> _getPokemonFromStorage(String id) {
    return Future.delayed(Duration.zero, () async {
      var poke = await Hive.openBox<String>("pokemons");
      return Pokemon.fromJson(jsonDecode(poke.get(id) as String));
    });
  }

  Future<Pokemon> _downloadPokemonInfoById(String id) async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$id', {'q': '{https}'});
    Pokemon pokemon = Pokemon();
    var response = await http.get(url);
    var poke = await Hive.openBox<String>("pokemons");

    if (response.statusCode == 200) {
      //скачанный текст кладем в локальной базе
      poke.put(id, response.body);
      pokemon = Pokemon.fromJson(jsonDecode(response.body));
      pokemons[pokemon.id.toString()] = pokemon;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return Future.delayed(Duration.zero, () => pokemon);
  }
}
