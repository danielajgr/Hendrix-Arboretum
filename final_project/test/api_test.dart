import 'package:final_project/api/tree.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('We can fetch different trees', () async {
    for (int treeId in [1,33,162]) {
      Tree t = await fetchTree(treeId);
      expect(t.id, treeId);
      for (String str in [
        t.buildingName,
        t.directionName,
        t.scientificName,
        t.latitude,
        t.longitude,
        t.imageURL,
        t.commonName
      ]) {
        expect(str.isEmpty, false);
      }
    }
  });

  test('We can fetch a random tree', () async {
    Tree t = await fetchRandomTree();
    for (String str in [
      t.buildingName,
      t.directionName,
      t.scientificName,
      t.latitude,
      t.longitude,
      t.imageURL,
      t.commonName
    ]) {
      expect(str.isEmpty, false);
    }
  });
}
