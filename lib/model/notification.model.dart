import 'package:landlord/model/models.dart';

class Notifications {
  int? id;
  bool? isRead;
  String? createdDate;
  String? title;
  String? text;
  String? url;
  Post? post;
  User? user;

  Notifications(
      {this.id,
      this.isRead,
      this.createdDate,
      this.title,
      this.text,
      this.url,
      this.post,
      this.user});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRead = json['isRead'];
    createdDate = json['createdDate'];
    title = json['title'];
    text = json[' text'];
    url = json['url'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isRead'] = this.isRead;
    data['createdDate'] = this.createdDate;
    data['title'] = this.title;
    data[' text'] = this.text;
    data['url'] = this.url;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
