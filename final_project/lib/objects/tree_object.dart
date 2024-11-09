class TreeObject{
  TreeObject({required this.treeid});
  int treeid;
  int likes = 0;

  void add_like(){
    likes ++;
  }
}