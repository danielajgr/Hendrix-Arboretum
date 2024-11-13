import 'package:final_project/api/tree.dart';
import 'package:flutter_test/flutter_test.dart';

void ensureTreeFields(Tree t) {
  expect(t.id != 0, true);
  expect(t.buildingName.isNotEmpty, true);
  expect(t.directionName.isNotEmpty, true);
  expect(t.scientificName.isNotEmpty, true);
  expect(t.latitude.isNotEmpty, true);
  expect(t.longitude.isNotEmpty, true);
  expect(t.commonName.isNotEmpty, true);
}

void main() {
  test('We can fetch different trees', () async {
    for (int treeId in [1, 33, 162]) {
      Tree t = await fetchTree(treeId);
      expect(t.id, treeId);
      ensureTreeFields(t);
    }
  });

  test('We can fetch a random tree', () async {
    Tree t = await fetchRandomTree();
    ensureTreeFields(t);
  });

  test('We can fetch trees near some latitude and longitude', () async {
    double lat = 35.1016222;
    double long = -92.4435278;
    List<Tree> ts = await fetchClosestTrees(lat, long, 11);
    for (Tree t in ts) {
      ensureTreeFields(t);
    }
  });
}
