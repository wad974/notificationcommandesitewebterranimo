import 'package:flutter/material.dart';

import 'sousdossier/list_orders.dart';

class OrdersPage extends StatefulWidget {
  static String routeName = 'orders';
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          // TITRE ORDERS + USER ACCOUNT
          Row(children: [
            const Row(
              children: [
                Text(
                  'ORDERS',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.shop,
                  size: 30,
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.notification_add),
                    SizedBox(
                      width: 10,
                    ),
                    Text('USERNAME'),
                    Icon(
                      Icons.person_pin,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
          ]),

          const SizedBox(
            height: 40,
          ),

          // TEXTFIELD INPUT SEARCH
          Row(
            children: [
              Container(
                width: 800,
                child: const TextField(
                  decoration: InputDecoration(
                      labelText: 'Search for Order ID, Customer , order Status',
                      border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //listezrezezs Commandes
          const listOrders(),
        ],
      ),
    );
  }
}
