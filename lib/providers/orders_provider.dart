import 'package:coffee_manager/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersProviderNotifier extends StateNotifier<List<Order>> {
  OrdersProviderNotifier() : super([]);

  void addNewOrder(Order newItem) {
    state = [...state, newItem];
  }

  void removeOrder(Order selectedOrder) {
    state = state.where((order) => order.id != selectedOrder.id).toList();

    // Send to firebase
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersProviderNotifier, List<Order>>(
        (ref) => OrdersProviderNotifier());
