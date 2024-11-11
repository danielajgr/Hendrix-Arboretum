import 'package:final_project/api/tree.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('We can fetch different trees', () async {
    for (int treeId in [1,33,162]) {
      Tree t = await fetchTree(treeId);
      expect(t.id, treeId);
      expect(t.noEmptyFields(), true);
    }
  });

  test('We can fetch a random tree', () async {
    Tree t = await fetchRandomTree();
    expect(t.noEmptyFields(), true);
  });
}
