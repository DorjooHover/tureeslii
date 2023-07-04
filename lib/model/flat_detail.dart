class FlatDetail {
  InPayment? inPayment;
  Flat? flat;
  Feature? feature;
  Furniture? furniture;
  RentCondition? rentCondition;
  Restrictions? restrictions;

  FlatDetail(
      {this.inPayment,
      this.flat,
      this.feature,
      this.furniture,
      this.rentCondition,
      this.restrictions});

  FlatDetail.fromJson(Map<String, dynamic> json) {
    inPayment = json['inPayment'] != null
        ? new InPayment.fromJson(json['inPayment'])
        : null;
    flat = json['flat'] != null ? new Flat.fromJson(json['flat']) : null;
    feature =
        json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
    furniture = json['furniture'] != null
        ? new Furniture.fromJson(json['furniture'])
        : null;
    rentCondition = json['rentCondition'] != null
        ? new RentCondition.fromJson(json['rentCondition'])
        : null;
    restrictions = json['restrictions'] != null
        ? new Restrictions.fromJson(json['restrictions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inPayment != null) {
      data['inPayment'] = this.inPayment!.toJson();
    }
    if (this.flat != null) {
      data['flat'] = this.flat!.toJson();
    }
    if (this.feature != null) {
      data['feature'] = this.feature!.toJson();
    }
    if (this.furniture != null) {
      data['furniture'] = this.furniture!.toJson();
    }
    if (this.rentCondition != null) {
      data['rentCondition'] = this.rentCondition!.toJson();
    }
    if (this.restrictions != null) {
      data['restrictions'] = this.restrictions!.toJson();
    }
    return data;
  }
}

class InPayment {
  DetailName? payment;
  DetailName? electronic;
  DetailName? accommodation;
  DetailName? internet;
  DetailName? sokh;

  InPayment(
      {this.payment,
      this.electronic,
      this.accommodation,
      this.internet,
      this.sokh});

  InPayment.fromJson(Map<String, dynamic> json) {
    payment =
        json['payment'] != null ? DetailName.fromJson(json['payment']) : null;
    electronic = json['electronic'] != null
        ? DetailName.fromJson(json['electronic'])
        : null;
    accommodation = json['accommodation'] != null
        ? DetailName.fromJson(json['accommodation'])
        : null;
    internet =
        json['internet'] != null ? DetailName.fromJson(json['internet']) : null;
    sokh = json['sokh'] != null ? DetailName.fromJson(json['sokh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (electronic != null) {
      data['electronic'] = electronic!.toJson();
    }
    if (accommodation != null) {
      data['accommodation'] = accommodation!.toJson();
    }
    if (internet != null) {
      data['internet'] = internet!.toJson();
    }
    if (sokh != null) {
      data['sokh'] = sokh!.toJson();
    }
    return data;
  }
}

class Flat {
  DetailName? heating;
  DetailName? waterSupply;
  DetailName? bathroom;
  DetailName? area;
  DetailName? floor;

  Flat({this.heating, this.waterSupply, this.bathroom, this.area, this.floor});

  Flat.fromJson(Map<String, dynamic> json) {
    heating =
        json['heating'] != null ? DetailName.fromJson(json['heating']) : null;
    waterSupply = json['waterSupply'] != null
        ? DetailName.fromJson(json['waterSupply'])
        : null;
    bathroom =
        json['bathroom'] != null ? DetailName.fromJson(json['bathroom']) : null;
    area = json['area'] != null ? DetailName.fromJson(json['area']) : null;
    floor = json['floor'] != null ? DetailName.fromJson(json['floor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (heating != null) {
      data['heating'] = heating!.toJson();
    }
    if (waterSupply != null) {
      data['waterSupply'] = waterSupply!.toJson();
    }
    if (bathroom != null) {
      data['bathroom'] = bathroom!.toJson();
    }
    if (area != null) {
      data['area'] = area!.toJson();
    }
    if (floor != null) {
      data['floor'] = floor!.toJson();
    }

    return data;
  }
}

class Feature {
  DetailName? elevator;
  DetailName? balcony;
  DetailName? net;
  DetailName? cabelTV;
  DetailName? oven;
  DetailName? washing;
  DetailName? refrigerator;

  Feature(
      {this.elevator,
      this.balcony,
      this.net,
      this.cabelTV,
      this.oven,
      this.washing,
      this.refrigerator});

  Feature.fromJson(Map<String, dynamic> json) {
    elevator =
        json['elevator'] != null ? DetailName.fromJson(json['elevator']) : null;
    balcony =
        json['balcony'] != null ? DetailName.fromJson(json['balcony']) : null;
    net = json['net'] != null ? DetailName.fromJson(json['net']) : null;
    cabelTV =
        json['cabelTV'] != null ? DetailName.fromJson(json['cabelTV']) : null;
    oven = json['oven'] != null ? DetailName.fromJson(json['oven']) : null;
    washing =
        json['washing'] != null ? DetailName.fromJson(json['washing']) : null;
    refrigerator = json['refrigerator'] != null
        ? DetailName.fromJson(json['refrigerator'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (elevator != null) {
      data['elevator'] = elevator!.toJson();
    }
    if (balcony != null) {
      data['balcony'] = balcony!.toJson();
    }
    if (net != null) {
      data['net'] = net!.toJson();
    }
    if (cabelTV != null) {
      data['cabelTV'] = cabelTV!.toJson();
    }
    if (oven != null) {
      data['oven'] = oven!.toJson();
    }
    if (washing != null) {
      data['washing'] = washing!.toJson();
    }
    if (refrigerator != null) {
      data['refrigerator'] = refrigerator!.toJson();
    }

    return data;
  }
}

class Furniture {
  DetailName? cabinet;
  DetailName? chair;
  DetailName? table;
  DetailName? sofa;
  DetailName? drawer;
  DetailName? kitchen;
  DetailName? bed;

  Furniture(
      {this.cabinet,
      this.chair,
      this.table,
      this.sofa,
      this.drawer,
      this.kitchen,
      this.bed});

  Furniture.fromJson(Map<String, dynamic> json) {
    cabinet =
        json['cabinet'] != null ? DetailName.fromJson(json['cabinet']) : null;
    chair = json['chair'] != null ? DetailName.fromJson(json['chair']) : null;
    table = json['table'] != null ? DetailName.fromJson(json['table']) : null;
    sofa = json['sofa'] != null ? DetailName.fromJson(json['sofa']) : null;
    drawer =
        json['drawer'] != null ? DetailName.fromJson(json['drawer']) : null;
    kitchen =
        json['kitchen'] != null ? DetailName.fromJson(json['kitchen']) : null;
    bed = json['bed'] != null ? DetailName.fromJson(json['bed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (cabinet != null) {
      data['cabinet'] = cabinet!.toJson();
    }
    if (chair != null) {
      data['chair'] = chair!.toJson();
    }
    if (table != null) {
      data['table'] = table!.toJson();
    }
    if (sofa != null) {
      data['sofa'] = sofa!.toJson();
    }
    if (drawer != null) {
      data['drawer'] = drawer!.toJson();
    }
    if (kitchen != null) {
      data['kitchen'] = kitchen!.toJson();
    }
    if (bed != null) {
      data['bed'] = bed!.toJson();
    }

    return data;
  }
}

class RentCondition {
  DetailName? whomRent;
  DetailName? bailCondition;
  DetailName? paymentCondition;
  DetailName? cancelCondition;
  DetailName? contractCondition;

  RentCondition(
      {this.whomRent,
      this.bailCondition,
      this.paymentCondition,
      this.cancelCondition,
      this.contractCondition});

  RentCondition.fromJson(Map<String, dynamic> json) {
    whomRent =
        json['whomRent'] != null ? DetailName.fromJson(json['whomRent']) : null;
    paymentCondition = json['paymentCondition'] != null
        ? DetailName.fromJson(json['paymentCondition'])
        : null;
    bailCondition = json['bailCondition'] != null
        ? DetailName.fromJson(json['bailCondition'])
        : null;
    cancelCondition = json['cancelCondition'] != null
        ? DetailName.fromJson(json['cancelCondition'])
        : null;
    contractCondition = json['contractCondition'] != null
        ? DetailName.fromJson(json['contractCondition'])
        : null;
    whomRent = json['whomRent'];
    bailCondition = json['bailCondition'];
    paymentCondition = json['paymentCondition'];
    cancelCondition = json['cancelCondition'];
    contractCondition = json['contractCondition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (whomRent != null) {
      data['whomRent'] = whomRent!.toJson();
    }
    if (bailCondition != null) {
      data['bailCondition'] = bailCondition!.toJson();
    }
    if (paymentCondition != null) {
      data['paymentCondition'] = paymentCondition!.toJson();
    }
    if (cancelCondition != null) {
      data['cancelCondition'] = cancelCondition!.toJson();
    }
    if (contractCondition != null) {
      data['contractCondition'] = contractCondition!.toJson();
    }

    return data;
  }
}

class Restrictions {
  DetailName? pet;
  DetailName? smoke;
  DetailName? invite;
  DetailName? isLiveTogether;
  DetailName? whomRent;

  Restrictions(
      {this.pet, this.smoke, this.invite, this.isLiveTogether, this.whomRent});

  Restrictions.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null ? DetailName.fromJson(json['pet']) : null;
    smoke = json['smoke'] != null ? DetailName.fromJson(json['smoke']) : null;
    invite =
        json['invite'] != null ? DetailName.fromJson(json['invite']) : null;
    isLiveTogether = json['isLiveTogether'] != null
        ? DetailName.fromJson(json['isLiveTogether'])
        : null;
    whomRent =
        json['whomRent'] != null ? DetailName.fromJson(json['whomRent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    if (smoke != null) {
      data['smoke'] = smoke!.toJson();
    }
    if (invite != null) {
      data['invite'] = invite!.toJson();
    }
    if (isLiveTogether != null) {
      data['isLiveTogether'] = isLiveTogether!.toJson();
    }
    if (whomRent != null) {
      data['whomRent'] = whomRent!.toJson();
    }

    return data;
  }
}

class DetailName {
  String? id;
  String? name;
  String? value;
  String? icon;
  String? type;
  String? warning;

  DetailName({this.id, this.value, this.name, this.icon, this.type, this.warning});

  DetailName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    name = json['name'];
    icon = json['icon'];
    type = json['type'];
    warning = json['warning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['icon'] = icon;
    data['type'] = type;
    data['warning'] = warning;

    return data;
  }
}
