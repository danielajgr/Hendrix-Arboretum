// https://docs.flutter.dev/cookbook/networking/fetch-data

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Tree {
  final int id;
  final String buildingName;
  final String directionName;
  final String scientificName;
  final String latitude;
  final String longitude;
  final String imageURL;
  final String commonName;

  const Tree({
    required this.id,
    required this.buildingName,
    required this.directionName,
    required this.scientificName,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
    required this.commonName,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'buildingName': String buildingName,
        'directionName': String directionName,
        'scientificName': String scientificName,
        'latitude': String latitude,
        'longitude': String longitude,
        'imageURL': String imageURL,
        'commonName': String commonName,
      } =>
        Tree(
          id: id,
          buildingName: buildingName,
          directionName: directionName,
          scientificName: scientificName,
          latitude: latitude,
          longitude: longitude,
          imageURL: imageURL,
          commonName: commonName,
        ),
      _ => throw const FormatException('Failed to load tree.'),
    };
  }
}

Future<Tree> fetchTreeHelper(String req) async {
  final response =
      await http.get(Uri.parse('https://arboretum.hendrix.edu/API/Trees/$req'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
      if (jlist.length == 1) {
        if (jlist[0] case Map<String, dynamic> jobject) {
          return Tree.fromJson(jobject);
        } else {
          throw Exception('Expected json object, got this instead: ${jlist[0]}');
        }
      } else {
        throw Exception(
            'Expected JSON list of length 1 (check tree id?), got this instead: $jlist');
      }
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception('Failed to load tree, status: ${response.statusCode}');
  }
}

Future<Tree> fetchTree(int id) async {
  return fetchTreeHelper('?id=$id');
}

Future<Tree> fetchRandomTree() async {
  return fetchTreeHelper('Random');
}
