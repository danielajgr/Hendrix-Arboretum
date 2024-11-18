// https://docs.flutter.dev/cookbook/networking/fetch-data

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'tree.dart';

class Specialty {
  final int id;
  final String title;
  final String excerpt;

  const Specialty({
    required this.id,
    required this.title,
    required this.excerpt,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'excerpt': String excerpt,
      } =>
        Specialty(
          id: id,
          title: title,
          excerpt: excerpt,
        ),
      _ => throw const FormatException('Failed to parse JSON for Specialty'),
    };
  }
}

Future<List<Specialty>> fetchAllSpecialties() async {
  final response =
      await http.get(Uri.parse('https://arboretum.hendrix.edu/API/Specialties/All'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
        List<Specialty> specialties = [];
        for (var entry in jlist) {
          if (entry case Map<String, dynamic> jobject) {
            specialties.add(Specialty.fromJson(jobject));
          } else {
            throw Exception('Expected json object, got this instead: $entry');
          }
        }
        return specialties;
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception('Failed to fetch all specialties, HTTP status: ${response.statusCode}');
  }
}

Future<List<Tree>> fetchTreesForSpecialty(Specialty s) async {
  final response =
      await http.get(Uri.parse('https://arboretum.hendrix.edu/API/Specialties/${s.title}'));

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
    throw Exception('Failed to load trees in specialty \'${s.title}\', HTTP status: ${response.statusCode}');
  }
}
