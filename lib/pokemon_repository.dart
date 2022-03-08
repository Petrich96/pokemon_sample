import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepo extends ChangeNotifier {
  Map<String, Pokemon> pokemons = {};
  Map<String, String> pokemonsName = {};

  Future<Pokemon> getPokemonById(String id) async {
    if (pokemons.containsKey(id))
      return Future.delayed(Duration.zero, () => pokemons[id]!);
    else
      return this._downloadPokemonInfoById(id);
  }

  getListOfPackemanName() => pokemons.keys;

  Future<Pokemon> _downloadPokemonInfoById(String id) async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$id', {'q': '{https}'});
    Pokemon pokemon = Pokemon();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      pokemon = Pokemon.fromJson(jsonDecode(response.body));
      pokemons[pokemon.id.toString()] = pokemon;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return Future.delayed(Duration.zero, () => pokemon);
  }




}
