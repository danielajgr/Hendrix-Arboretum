class Comment {
  Comment({required this.name, required this.message});

  final String name;
  final String message;
  
  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(name: json['name'], message: json['message']);
  }


}

