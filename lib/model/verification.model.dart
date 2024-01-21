import 'package:landlord/model/models.dart';

class Verification {
  int? id;
  String? status;
  int? userId;
  String? front;
  String? back;
  String? bankAccNo;
  String? bankName;
  String? bankAccName;
  String? postDate;
  String? verifiedDate;
  List<User>? verified;

  Verification(
      {this.id,
      this.status,
      this.userId,
      this.front,
      this.back,
      this.bankAccNo,
      this.bankName,
      this.bankAccName,
      this.postDate,
      this.verifiedDate,
      this.verified});

  Verification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userId = json['userId'];
    front = json['front'];
    back = json['back'];
    bankAccNo = json['bankAccNo'];
    bankName = json['bankName'];
    bankAccName = json['bankAccName'];
    postDate = json['postDate'];
    verifiedDate = json['verifiedDate'];
    if (json['verified'] != null) {
      verified = <User>[];
      json['verified'].forEach((v) {
        verified!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['front'] = this.front;
    data['back'] = this.back;
    data['bankAccNo'] = this.bankAccNo;
    data['bankName'] = this.bankName;
    data['bankAccName'] = this.bankAccName;
    data['postDate'] = this.postDate;
    data['verifiedDate'] = this.verifiedDate;
    if (this.verified != null) {
      data['verified'] = this.verified!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
