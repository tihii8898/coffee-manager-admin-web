import 'package:coffee_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableItem extends StatelessWidget {
  final Order order;
  const TableItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in order.coffeeList) {
      total += item['drink']['price'];
    }

    return GestureDetector(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Time: ${DateFormat('dd-MM-yyyy hh:mm:ss').format(order.time)}'),
              for (var index = 0; index < order.coffeeList.length; index++)
                Text(
                  '${order.coffeeList[index]['number']} ${order.coffeeList[index]['drink']['name']} - ${order.coffeeList[index]['drink']['price']}',
                  textAlign: TextAlign.start,
                ),
              Row(
                children: [
                  Text(
                    'Total: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('$total đ'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Add drink',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent),
                    icon: const Icon(
                      Icons.payments,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Go pay',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
