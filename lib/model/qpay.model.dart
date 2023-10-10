class QPay {
  String? invoiceId;
  String? qrText;
  String? qrImage;
  String? qPayShortUrl;
  List<Urls>? urls;

  QPay(
      {this.invoiceId,
      this.qrText,
      this.qrImage,
      this.qPayShortUrl,
      this.urls});

  QPay.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    qrText = json['qr_text'];
    qrImage = json['qr_image'];
    qPayShortUrl = json['qPay_shortUrl'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['qr_text'] = this.qrText;
    data['qr_image'] = this.qrImage;
    data['qPay_shortUrl'] = this.qPayShortUrl;
    if (this.urls != null) {
      data['urls'] = this.urls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urls {
  String? name;
  String? description;
  String? logo;
  String? link;

  Urls({this.name, this.description, this.logo, this.link});

  Urls.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['link'] = this.link;
    return data;
  }
}