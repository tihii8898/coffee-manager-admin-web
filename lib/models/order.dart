import 'package:coffee_manager/models/drink.dart';

class Order {
  final String id;
  final List<Map<String, dynamic>> coffeeList;
  final DateTime time = DateTime.now();
  Order(this.id, this.coffeeList);
}
