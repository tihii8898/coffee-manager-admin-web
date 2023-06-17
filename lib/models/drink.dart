class Drink {
  final String name;
  final double ice;
  final double price;
  final double sugar;

  const Drink({
    required this.name,
    required this.ice,
    required this.sugar,
    required this.price,
  });
}

abstract class Coffee extends Drink {
  Coffee(
      {required super.name,
      required super.ice,
      required super.sugar,
      required super.price});
  Map<String, dynamic> toJson();
}

class PhinCoffee extends Coffee {
  bool noIce = false;
  PhinCoffee(this.noIce)
      : super(
          name: noIce ? 'Hot Phin Coffee' : 'Cold Phin coffee',
          ice: noIce ? 0 : 50,
          sugar: 50,
          price: 20000,
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ice'] = ice;
    data['sugar'] = sugar;
    data['price'] = price;

    return data;
  }
}

class MilkCoffee extends Coffee {
  double? milkRatio = 50;
  MilkCoffee(this.milkRatio)
      : super(
          name: 'Milk coffee',
          ice: 50,
          sugar: 0,
          price: 25000,
        );
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['milkRatio'] = milkRatio;
    data['ice'] = ice;
    data['sugar'] = sugar;
    data['price'] = price;
    return data;
  }
}

class WhiteCoffee extends Coffee {
  double milkRatio = 50;
  double condensedMilkRatio = 50;
  WhiteCoffee(this.milkRatio, this.condensedMilkRatio)
      : super(
          name: 'White coffee',
          ice: 50,
          sugar: 0,
          price: 30000,
        );
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['milkRatio'] = milkRatio;
    data['condensedMilkRatio'] = condensedMilkRatio;
    data['ice'] = ice;
    data['sugar'] = sugar;
    data['price'] = price;
    return data;
  }
}
