class Apartment {
  List<String>? img;
  int? price;
  String? date;
  String? title;
  int? door;
  int? bed;
  int? bath;

  Apartment(
      {this.img,
      this.price,
      this.date,
      this.title,
      this.door,
      this.bed,
      this.bath});

  Apartment.fromJson(Map<String, dynamic> json) {
    img = json['img'].cast<String>();
    price = json['price'];
    date = json['date'];
    title = json['title'];
    door = json['door'];
    bed = json['bed'];
    bath = json['bath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['price'] = price;
    data['date'] = date;
    data['title'] = title;
    data['door'] = door;
    data['bed'] = bed;
    data['bath'] = bath;
    return data;
  }
}
