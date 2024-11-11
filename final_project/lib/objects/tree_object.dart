class TreeObject{
  TreeObject({required this.treeid});
  int treeid;
  int likes = 0;
  
  int get_likes(){
    return likes;
  }

  void add_like(){
    likes ++;
  }

  int get_treeId(){
    return treeid;
  }
}