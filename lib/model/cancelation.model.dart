class Cancelation {
  int? id;
  String? name;
  String? title;
  String? description;
  String? section1title;
  String? section1desc;
  String? section2title;
  String? section2desc;
  String? section3title;
  String? section3desc;

  Cancelation(
      {this.id,
      this.name,
      this.title,
      this.description,
      this.section1title,
      this.section1desc,
      this.section2title,
      this.section2desc,
      this.section3title,
      this.section3desc});

  Cancelation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    section1title = json['section1title'];
    section1desc = json['section1desc'];
    section2title = json['section2title'];
    section2desc = json['section2desc'];
    section3title = json['section3title'];
    section3desc = json['section3desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['section1title'] = this.section1title;
    data['section1desc'] = this.section1desc;
    data['section2title'] = this.section2title;
    data['section2desc'] = this.section2desc;
    data['section3title'] = this.section3title;
    data['section3desc'] = this.section3desc;
    return data;
  }
}
