
class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
  String? userType;

  String? degree;
  String? userStatus;
  int? alert;
  double? ratingAvg;
  List<String>? userServices;
  String? createdAt;
  String? updatedAt;
  Account? account;
  String? certificate;
  int? experience;
  String? licenseNumber;
  String? taxNumber;
  String? registerNumber;
  String? profileImg;
  String? email;
  String? workLocationString;
  String? officeLocationString;
  List<String>? phoneNumbers;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phone,
      this.userType,

      this.degree,
      this.userStatus,
      this.alert,
      this.profileImg,
      this.userServices,
      this.createdAt,
      this.workLocationString,
      this.officeLocationString,
      this.updatedAt,
      this.ratingAvg,
      this.account,
      this.certificate,
      this.experience,
      this.licenseNumber,

      this.registerNumber,

      this.taxNumber,
      this.email,
      this.phoneNumbers,
});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    userType = json['userType'];
    workLocationString = json['workLocationString'];
    officeLocationString = json['officeLocationString'];
    
    
    degree = json['degree'];
   
    if (json['phoneNumbers'] != null) {
      phoneNumbers = <String>[];
      json['phoneNumbers'].forEach((v) {
        phoneNumbers!.add(v.toString());
      });
    }
    userStatus = json['userStatus'];
    email = json['email'];
    alert = json['alert'];
    profileImg = json['profileImg'];
    ratingAvg = double.parse(
        json['ratingAvg'] == null ? '0' : json['ratingAvg'].toString());
    if (json['userServices'] != null) {
      userServices = <String>[];
      json['userServices'].forEach((v) {
        userServices!.add(v.toString());
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    certificate = json['certificate'];
    experience = json['experience'];
    licenseNumber = json['licenseNumber'];
   
    taxNumber = json['taxNumber'];
    registerNumber = json['registerNumber'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['userType'] = userType;
    data['officeLocationString'] = officeLocationString;
    data['workLocationString'] = workLocationString;
    
    data['degree'] = degree;
   
    data['userStatus'] = userStatus;
    data['alert'] = alert;
    data['profileImg'] = profileImg;
    data['ratingAvg'] = ratingAvg;
    if (userServices != null) {
      data['userServices'] = userServices;
    }
    if (phoneNumbers != null) {
      data['phoneNumbers'] = phoneNumbers;
    }

    data['createdAt'] = createdAt;
    data['email'] = email;
    data['updatedAt'] = updatedAt;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['certificate'] = certificate;
    data['experience'] = experience;
    data['licenseNumber'] = licenseNumber;
   
   
    data['taxNumber'] = taxNumber;
    data['registerNumber'] = registerNumber;
   
  
    return data;
  }
}

class Account {
  int? accountNumber;
  String? username;
  String? bank;

  Account({this.accountNumber, this.username, this.bank});

  Account.fromJson(Map<String, dynamic> json) {
    accountNumber = json['accountNumber'];
    username = json['username'];
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountNumber'] = accountNumber;
    data['username'] = username;
    data['bank'] = bank;
    return data;
  }
}
