import 'package:coffee_manager/data/dummy.dart';
import 'package:coffee_manager/providers/orders_provider.dart';
import 'package:coffee_manager/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(ordersProvider);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: dummyOrders.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            childAspectRatio: 1 / 2,
            crossAxisSpacing: 1,
            mainAxisExtent: 250,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => TableItem(
            order: dummyOrders[index],
          ),
        ),
      ),
    );
  }
}
