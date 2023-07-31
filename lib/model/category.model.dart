import 'package:landlord/model/models.dart';

class Category {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  bool? isOnHome;
  int? parentId;
  String? catIcon;
  List<Post>? post;
  List<UserSubsCat>? userSubsCat;

  Category(
      {this.id,
      this.name,
      this.description,
      this.isActive,
      this.isOnHome,
      this.parentId,
      this.catIcon,
      this.post,
      this.userSubsCat});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    isOnHome = json['isOnHome'];
    parentId = json['parentId'];
    catIcon = json['catIcon'];
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
    if (json['userSubsCat'] != null) {
      userSubsCat = <UserSubsCat>[];
      json['userSubsCat'].forEach((v) {
        userSubsCat!.add(new UserSubsCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['isOnHome'] = this.isOnHome;
    data['parentId'] = this.parentId;
    data['catIcon'] = this.catIcon;
    if (this.post != null) {
      data['post'] = this.post!.map((v) => v.toJson()).toList();
    }
    if (this.userSubsCat != null) {
      data['userSubsCat'] = this.userSubsCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

