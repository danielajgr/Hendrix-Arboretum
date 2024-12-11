import 'dart:convert';

import 'tree.dart';
import 'package:http/http.dart' as http;

class SpeciesName {
  final int id;
  final String name;

  const SpeciesName({required this.id, required this.name});

  factory SpeciesName.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name} => SpeciesName(id: id, name: name),
      _ => throw FormatException('Failed to load SpeciesName: $json'),
    };
  }
}

Future<List<SpeciesName>> fetchSpeciesNames(bool scientificName) async {
  final category = scientificName ? "Scientific" : "Common";
  final response = await http.get(
      Uri.parse('https://arboretum.hendrix.edu/API/$category/All'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
      List<SpeciesName> names = [];
      for (var entry in jlist) {
        if (entry case Map<String, dynamic> jobject) {
          names.add(SpeciesName.fromJson(jobject));
        } else {
          throw Exception('Expected json object, got this instead: $entry');
        }
      }
      return names;
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception(
        'Failed to load list of species, in category \'$category\' HTTP status: ${response.statusCode}');
  }
}

Future<List<Tree>> fetchTreesBySpecies(bool scientificName, String name) async {
  final category = scientificName ? "Scientific" : "Common";
  final response = await http.get(
      Uri.parse('https://arboretum.hendrix.edu/API/$category/?name=$name'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
      List<Tree> trees = [];
      for (var entry in jlist) {
        if (entry case Map<String, dynamic> jobject) {
          trees.add(Tree.fromJson(jobject));
        } else {
          throw Exception('Expected json object, got this instead: $entry');
        }
      }
      return trees;
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception(
        'Failed to load trees by name \'$name\', in category \'$category\' HTTP status: ${response.statusCode}');
  }
}
