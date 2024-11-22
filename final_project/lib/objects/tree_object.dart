import '../api/tree.dart';

class TreeObject implements Comparable<TreeObject> {
  TreeObject({required this.treeid});
  int treeid;
  int likes = 0;

  Future<Tree> getTree() {
    return fetchTree(treeid);
  }

  void add_like() {
    likes++;
  }

  void remove_Like() {
    likes--;
  }

  // Automatically adjusts order of TreeObjects
  @override
  int compareTo(TreeObject other) {
    return other.likes.compareTo(likes);
  }
}
