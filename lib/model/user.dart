class User {
  String? accessToken;
  int? id;
  String? email;
  int? itemCnt;
  String? birthdate;
  double? incomeAmount;
  String? firstname;
  String? gender;
  String? lastname;
  String? companyName;
  String? companyRegistry;
  String? mobile;
  String? rentPersonCount;
  String? job;
  String? jobTitle;
  String? profession;
  String? payType;
  String? description;
  String? profilePic;
  String? fbId;
  bool? orderNotification;
  bool? productAdsNotification;
  bool? mobileVerified;
  bool? emailVerified;
  bool? verified;
  bool? isCreator;
  String? createdAt;
  Roles? roles;
  List<UserSubsCat>? userSubsCat;

  User(
      {this.accessToken,
      this.id,
      this.email,
      this.itemCnt,
      this.birthdate,
      this.incomeAmount,
      this.firstname,
      this.gender,
      this.lastname,
      this.companyName,
      this.companyRegistry,
      this.mobile,
      this.rentPersonCount,
      this.job,
      this.jobTitle,
      this.profession,
      this.payType,
      this.description,
      this.profilePic,
      this.fbId,
      this.orderNotification,
      this.productAdsNotification,
      this.mobileVerified,
      this.emailVerified,
      this.verified,
      this.isCreator,
      this.createdAt,
      this.roles,
      this.userSubsCat});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    id = json['id'];
    email = json['email'];
    itemCnt = json['itemCnt'];
    birthdate = json['birthdate'];
    incomeAmount = double.parse(json['incomeAmount'].toString());
    firstname = json['firstname'];
    gender = json['gender'];
    lastname = json['lastname'];
    companyName = json['companyName'];
    companyRegistry = json['companyRegistry'];
    mobile = json['mobile'];
    rentPersonCount = json['rentPersonCount'];
    job = json['job'];
    jobTitle = json['jobTitle'];
    profession = json['profession'];
    payType = json['payType'];
    description = json['description'];
    profilePic = json['profilePic'];
    fbId = json['fbId'];
    orderNotification = json['order_notification'];
    productAdsNotification = json['product_ads_notification'];
    mobileVerified = json['mobile_verified'];
    emailVerified = json['EmailVerified'];
    verified = json['verified'];
    isCreator = json['isCreator'];
    createdAt = json['created_at'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
    if (json['userSubsCat'] != null) {
      userSubsCat = <UserSubsCat>[];
      json['userSubsCat'].forEach((v) {
        userSubsCat!.add(new UserSubsCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['id'] = this.id;
    data['email'] = this.email;
    data['itemCnt'] = this.itemCnt;
    data['birthdate'] = this.birthdate;
    data['incomeAmount'] = this.incomeAmount;
    data['firstname'] = this.firstname;
    data['gender'] = this.gender;
    data['lastname'] = this.lastname;
    data['companyName'] = this.companyName;
    data['companyRegistry'] = this.companyRegistry;
    data['mobile'] = this.mobile;
    data['rentPersonCount'] = this.rentPersonCount;
    data['job'] = this.job;
    data['jobTitle'] = this.jobTitle;
    data['profession'] = this.profession;
    data['payType'] = this.payType;
    data['description'] = this.description;
    data['profilePic'] = this.profilePic;
    data['fbId'] = this.fbId;
    data['order_notification'] = this.orderNotification;
    data['product_ads_notification'] = this.productAdsNotification;
    data['mobile_verified'] = this.mobileVerified;
    data['EmailVerified'] = this.emailVerified;
    data['verified'] = this.verified;
    data['isCreator'] = this.isCreator;
    data['created_at'] = this.createdAt;
    if (this.roles != null) {
      data['roles'] = this.roles!.toJson();
    }
    if (this.userSubsCat != null) {
      data['userSubsCat'] = this.userSubsCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class UserSubsCat {
  int? id;
  int? categoryId;
  String? category;
  User? user;

  UserSubsCat({this.id, this.categoryId, this.category});

  UserSubsCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    category = json['category'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    if (this.user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
