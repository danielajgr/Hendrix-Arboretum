// https://docs.flutter.dev/cookbook/networking/fetch-data

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Tree {
  final int id;
  final String buildingName;
  final String directionName;
  final String scientificName;
  final double latitude;
  final double longitude;
  final String imageURL;
  final String commonName;
  final int height;
  final double dbh;

  const Tree(
      {required this.id,
      required this.buildingName,
      required this.directionName,
      required this.scientificName,
      required this.latitude,
      required this.longitude,
      required this.imageURL,
      required this.commonName,
      required this.height,
      required this.dbh});

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
        'height': int height,
        'dbh': double dbh
      } =>
        Tree(
          id: id,
          buildingName: buildingName,
          directionName: directionName,
          scientificName: scientificName,
          latitude: double.parse(latitude),
          longitude: double.parse(longitude),
          imageURL: imageURL,
          commonName: commonName,
          height: height,
          dbh: dbh,
        ),
      _ => throw FormatException('Failed to load tree. $json'),
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
          throw Exception(
              'Expected json object, got this instead: ${jlist[0]}');
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

Future<List<Tree>> fetchTreeMultiHelper(String req, int count) async {
  final response =
      await http.get(Uri.parse('https://arboretum.hendrix.edu/API/Trees/$req'));

  if (response.statusCode == 200) {
    var dec = jsonDecode(response.body);
    if (dec case List<dynamic> jlist) {
      if (jlist.length == count) {
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
        throw Exception(
            'Expected JSON list of length $count, got this list instead: $jlist');
      }
    } else {
      throw Exception('Expected JSON list, got this instead: $dec');
    }
  } else {
    throw Exception('Failed to load trees, status: ${response.statusCode}');
  }
}

Future<Tree> fetchTree(int id) async {
  return fetchTreeHelper('?id=$id');
}

Future<Tree> fetchRandomTree() async {
  return fetchTreeHelper('Random');
}

Future<List<Tree>> fetchClosestTrees(
    double latitude, double longitude, int count) {
  return fetchTreeMultiHelper(
      "Location/?lat=$latitude&lon=$longitude&count=$count", count);
}
