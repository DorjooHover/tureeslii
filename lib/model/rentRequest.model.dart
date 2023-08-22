import 'package:landlord/model/models.dart';

class RentRequest {
  int? id;
  String? startDate;
  String? endDate;
  int? duration;
  String? status;
  String? postDate;
  int? price;
  int? fee;
  int? totalPrice;
  String? qpayInvoiceId;
  String? paidDate;
  Post? post;
  User? user;

  RentRequest(
      {this.id,
      this.startDate,
      this.endDate,
      this.duration,
      this.status,
      this.postDate,
      this.price,
      this.fee,
      this.totalPrice,
      this.qpayInvoiceId,
      this.paidDate,
      this.post,
      this.user});

  RentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    status = json['status'];
    postDate = json['postDate'];
    price = json['price'];
    fee = json['fee'];
    totalPrice = json['totalPrice'];
    qpayInvoiceId = json['qpayInvoiceId'];
    paidDate = json['paidDate'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['postDate'] = this.postDate;
    data['price'] = this.price;
    data['fee'] = this.fee;
    data['totalPrice'] = this.totalPrice;
    data['qpayInvoiceId'] = this.qpayInvoiceId;
    data['paidDate'] = this.paidDate;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
