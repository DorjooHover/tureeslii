import 'package:landlord/model/models.dart';

class Post {
  int? id;
  String? title;
  String? description;
  String? postDate;
  double? price;
  double? priceDaily;
  bool? depositRequired;
  String? depositTerm;
  String? paymentTerm;
  List<String>? priceIncluded;
  int? bedroom;
  int? bathroom;
  int? kitchen;
  int? livingRoom;
  int? roomCount;
  int? singleBed;
  int? doubleBed;
  int? bedCount;
  String? heating;
  String? waterSupply;
  String? restroom;
  bool? elevator;
  bool? balcony;
  bool? washingMachine;
  bool? stove;
  bool? hasFurniture;
  List<String>? furnitures;
  String? apartmentNo;
  String? doorNo;
  bool? kitchenFurniture;
  bool? wifi;
  String? cancelTerm;
  String? priceTerm;
  bool? tvCable;
  bool? refrigerator;
  String? startDate;
  int? minDurationMonthly;
  int? minDurationDaily;
  bool? dailyRent;
  bool? monthlyRent;
  String? status;
  String? address;
  int? floor;
  bool? petAllowed;
  bool? guestAllowed;
  bool? special;
  bool? smokingAllowed;
  bool? livingProperty;
  int? acceptedTenants;
  String? acceptedGender;
  String? city;
  String? district;
  String? state;
  double? long;
  double? lat;
  double? plot;
  List<PostAttachments>? postAttachments;
  User? user;

  Post(
      {this.id,
      this.title,
      this.description,
      this.postDate,
      this.price,
      this.priceDaily,
      this.depositRequired,
      this.depositTerm,
      this.paymentTerm,
      this.priceIncluded,
      this.bedroom,
      this.bathroom,
      this.kitchen,
      this.livingRoom,
      this.roomCount,
      this.singleBed,
      this.doubleBed,
      this.bedCount,
      this.heating,
      this.waterSupply,
      this.restroom,
      this.elevator,
      this.balcony,
      this.washingMachine,
      this.stove,
      this.hasFurniture,
      this.furnitures,
      this.apartmentNo,
      this.doorNo,
      this.kitchenFurniture,
      this.wifi,
      this.cancelTerm,
      this.priceTerm,
      this.tvCable,
      this.refrigerator,
      this.startDate,
      this.minDurationMonthly,
      this.minDurationDaily,
      this.dailyRent,
      this.monthlyRent,
      this.status,
      this.address,
      this.floor,
      this.petAllowed,
      this.guestAllowed,
      this.special,
      this.smokingAllowed,
      this.livingProperty,
      this.acceptedTenants,
      this.acceptedGender,
      this.city,
      this.district,
      this.state,
      this.long,
      this.lat,
      this.plot,
      this.postAttachments,
      this.user});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    postDate = json['postDate'];
    price = double.parse(json['price'].toString());
    priceDaily = double.parse(json['priceDaily'].toString());
    depositRequired = json['depositRequired'];
    depositTerm = json['depositTerm'];
    paymentTerm = json['paymentTerm'];
    priceIncluded = json['priceIncluded'].cast<String>();
    bedroom = json['bedroom'];
    bathroom = json['bathroom'];
    kitchen = json['kitchen'];
    livingRoom = json['livingRoom'];
    roomCount = json['roomCount'];
    singleBed = json['singleBed'];
    doubleBed = json['doubleBed'];
    bedCount = json['bedCount'];
    heating = json['heating'];
    waterSupply = json['waterSupply'];
    restroom = json['restroom'];
    elevator = json['elevator'];
    balcony = json['balcony'];
    washingMachine = json['washingMachine'];
    stove = json['stove'];
    hasFurniture = json['hasFurniture'];
    furnitures = json['furnitures'].cast<String>();
    apartmentNo = json['apartment_no'];
    doorNo = json['door_no'];
    kitchenFurniture = json['kitchenFurniture'];
    wifi = json['wifi'];
    cancelTerm = json['cancelTerm'];
    priceTerm = json['priceTerm'];
    tvCable = json['tvCable'];
    refrigerator = json['refrigerator'];
    startDate = json['startDate'];
    minDurationMonthly = json['minDurationMonthly'];
    minDurationDaily = json['minDurationDaily'];
    dailyRent = json['dailyRent'];
    monthlyRent = json['monthlyRent'];
    status = json['status'];
    address = json['address'];
    floor = json['floor'];
    petAllowed = json['petAllowed'];
    guestAllowed = json['guestAllowed'];
    special = json['special'];
    smokingAllowed = json['smokingAllowed'];
    livingProperty = json['livingProperty'];
    acceptedTenants = json['acceptedTenants'];
    acceptedGender = json['acceptedGender'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    long = json['long'];
    lat = json['lat'];
    plot = double.parse(json['plot'].toString());
    if (json['postAttachments'] != null) {
      postAttachments = <PostAttachments>[];
      json['postAttachments'].forEach((v) {
        postAttachments!.add(new PostAttachments.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['postDate'] = this.postDate;
    data['price'] = this.price;
    data['priceDaily'] = this.priceDaily;
    data['depositRequired'] = this.depositRequired;
    data['depositTerm'] = this.depositTerm;
    data['paymentTerm'] = this.paymentTerm;
    data['priceIncluded'] = this.priceIncluded;
    data['bedroom'] = this.bedroom;
    data['bathroom'] = this.bathroom;
    data['kitchen'] = this.kitchen;
    data['livingRoom'] = this.livingRoom;
    data['roomCount'] = this.roomCount;
    data['singleBed'] = this.singleBed;
    data['doubleBed'] = this.doubleBed;
    data['bedCount'] = this.bedCount;
    data['heating'] = this.heating;
    data['waterSupply'] = this.waterSupply;
    data['restroom'] = this.restroom;
    data['elevator'] = this.elevator;
    data['balcony'] = this.balcony;
    data['washingMachine'] = this.washingMachine;
    data['stove'] = this.stove;
    data['hasFurniture'] = this.hasFurniture;
    data['furnitures'] = this.furnitures;
    data['apartment_no'] = this.apartmentNo;
    data['door_no'] = this.doorNo;
    data['kitchenFurniture'] = this.kitchenFurniture;
    data['wifi'] = this.wifi;
    data['cancelTerm'] = this.cancelTerm;
    data['priceTerm'] = this.priceTerm;
    data['tvCable'] = this.tvCable;
    data['refrigerator'] = this.refrigerator;
    data['startDate'] = this.startDate;
    data['minDurationMonthly'] = this.minDurationMonthly;
    data['minDurationDaily'] = this.minDurationDaily;
    data['dailyRent'] = this.dailyRent;
    data['monthlyRent'] = this.monthlyRent;
    data['status'] = this.status;
    data['address'] = this.address;
    data['floor'] = this.floor;
    data['petAllowed'] = this.petAllowed;
    data['guestAllowed'] = this.guestAllowed;
    data['special'] = this.special;
    data['smokingAllowed'] = this.smokingAllowed;
    data['livingProperty'] = this.livingProperty;
    data['acceptedTenants'] = this.acceptedTenants;
    data['acceptedGender'] = this.acceptedGender;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['plot'] = this.plot;
    if (this.postAttachments != null) {
      data['postAttachments'] =
          this.postAttachments!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class PostAttachments {
  int? id;
  String? file;
  String? fileThumb;

  PostAttachments({this.id, this.file, this.fileThumb});

  PostAttachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    fileThumb = json['fileThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['fileThumb'] = this.fileThumb;
    return data;
  }
}
