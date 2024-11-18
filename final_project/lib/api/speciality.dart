// https://docs.flutter.dev/cookbook/networking/fetch-data

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Speciality {
  final int id;
  final String title;
  final String excerpt;

  const Speciality({
    required this.id,
    required this.title,
    required this.excerpt,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'excerpt': String excerpt,
      } =>
        Speciality(
          id: id,
          title: title,
          excerpt: excerpt,
        ),
      _ => throw const FormatException('Failed to parse JSON for Speciality'),
    };
  }
}

Future<List<Speciality>> getAllSpecialties() async {
  final response =
      await http.get(Uri.parse('https://arboretum.hendrix.edu/API/Specialties/All'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
        List<Speciality> specialities = [];
        for (var entry in jlist) {
          if (entry case Map<String, dynamic> jobject) {
            specialities.add(Speciality.fromJson(jobject));
          } else {
            throw Exception('Expected json object, got this instead: $entry');
          }
        }
        return specialities;
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception('Failed to fetch all specialities, HTTP status: ${response.statusCode}');
  }
}
