//Model class of the api here the data's are passed through json with null safety
class PizzaModel {
  PizzaModel({
    required this.id,
    required this.name,
    required this.isVeg,
    required this.description,
    required this.defaultCrust,
    required this.crusts,
  });
  late final String id;
  late final String name;
  late final bool isVeg;
  late final String description;
  late final int defaultCrust;
  late final List<Crusts> crusts;

  PizzaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isVeg = json['isVeg'];
    description = json['description'];
    defaultCrust = json['defaultCrust'];
    crusts = List.from(json['crusts']).map((e) => Crusts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isVeg'] = isVeg;
    _data['description'] = description;
    _data['defaultCrust'] = defaultCrust;
    _data['crusts'] = crusts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Crusts {
  Crusts({
    required this.id,
    required this.name,
    required this.defaultSize,
    required this.sizes,
  });
  late final int id;
  late final String name;
  late final int defaultSize;
  late final List<Sizes> sizes;

  Crusts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultSize = json['defaultSize'];
    sizes = List.from(json['sizes']).map((e) => Sizes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['defaultSize'] = defaultSize;
    _data['sizes'] = sizes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Sizes {
  Sizes({
    required this.id,
    required this.name,
    required this.price,
  });
  late final int id;
  late final String name;
  late final int price;

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    return _data;
  }
}
