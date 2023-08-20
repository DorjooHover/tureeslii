class Config {
  int? id;
  String? key;
  String? value;
  String? title;
  int? version;

  Config({this.id, this.key, this.value, this.title, this.version});

  Config.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    title = json['title'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['title'] = this.title;
    data['version'] = this.version;
    return data;
  }
}

class City {
  String? name;
  List<double>? location;

  City({this.name, this.location});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    return data;
  }
}
