class ErrorHandler {
  bool? success;
  String? message;
  String? error;
  int? statusCode;
  dynamic data;

  ErrorHandler(
      {this.success, this.message, this.data, this.error, this.statusCode});

  ErrorHandler.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['error'] = error;
    data['data'] = this.data;
    data['statusCode'] = statusCode;

    return data;
  }
}

class FilterData {
  String? field;
  String? op;
  String? qry;

  FilterData({this.field, this.op, this.qry});

  FilterData.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    op = json['op'];
    qry = json['qry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['op'] = this.op;
    data['qry'] = this.qry;
    return data;
  }
}

class SortData {
  String? field;
  String? dir;

  SortData({
    this.field,
    this.dir,
  });

  SortData.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    dir = json['dir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['dir'] = this.dir;

    return data;
  }
}
