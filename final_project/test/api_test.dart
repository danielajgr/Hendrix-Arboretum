import 'package:final_project/api/by_name.dart';
import 'package:final_project/api/speciality.dart';
import 'package:final_project/api/tree.dart';
import 'package:flutter_test/flutter_test.dart';

void ensureTreeFields(Tree t) {
  expect(t.id != 0, true);
  expect(t.buildingName.isNotEmpty, true);
  expect(t.directionName.isNotEmpty, true);
  expect(t.scientificName.isNotEmpty, true);
  expect(t.latitude != 0, true);
  expect(t.longitude != 0, true);
  expect(t.commonName.isNotEmpty, true);
}

void ensureSpecialityFields(Specialty s) {
  expect(s.id != 0, true);
  expect(s.title.isNotEmpty, true);
  expect(s.excerpt.isNotEmpty, true);
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

  test('We can get a list of all specialties', () async {
    List<Specialty> sps = await fetchAllSpecialties();
    expect(sps.isNotEmpty, true);
    for (Specialty s in sps) {
      ensureSpecialityFields(s);
    }
  });

  test('We can get a list trees from a specialty', () async {
    List<Specialty> sps = await fetchAllSpecialties();
    expect(sps.isNotEmpty, true);
    Specialty s = sps.last;
    ensureSpecialityFields(s);

    List<Tree> ts = await fetchTreesForSpecialty(s);
    for (Tree t in ts) {
      ensureTreeFields(t);
    }
  });

  test('We can fetch trees by scientific name', () async {
    // There are only 2 of these, so this will be a fast query
    // Hopefully this doesn't break in the future
    const science = 'Cercis canadensis L. var. texensis (S. Watson) M. Hopkins';

    List<Tree> ts = await fetchTreesBySpecies(true, science);

    expect(ts.isNotEmpty, true);
    for (Tree t in ts) {
      ensureTreeFields(t);
    }
  });

  test('We can fetch trees by common name', () async {
    // There are only 2 of these, so this will be a fast query
    // Hopefully this doesn't break in the future
    const common = 'Redbud, Texas';

    List<Tree> ts = await fetchTreesBySpecies(false, common);

    expect(ts.isNotEmpty, true);
    for (Tree t in ts) {
      ensureTreeFields(t);
    }
  });
}
