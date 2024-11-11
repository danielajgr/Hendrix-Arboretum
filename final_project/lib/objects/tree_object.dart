import '../api/tree.dart';

class TreeObject {
  TreeObject({required this.treeid});
  int treeid;
  int likes = 0;

  void addLike() {
    likes++;
  }

  Future<Tree> getTree() {
    return fetchTree(treeid);
  }
}
