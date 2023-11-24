class NoteModel {
  int? id;
  String? title;
  String? body;
  String? image;
  int? userId;

  NoteModel({this.id, this.title, this.body, this.image, this.userId});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}