import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Exemple de données
  final List<Map<String, dynamic>> orders = [
    {'OrderId': '001', 'Customer': 'John Doe', 'Date': '2024-05-02', 'Caisse': '1'},
    {'OrderId': '002', 'Customer': 'Jane Smith', 'Date': '2024-05-03', 'Caisse': '2'},
    // Ajoutez d'autres données ici
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order List Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Order ID')),
                    DataColumn(label: Text('Customer')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Caisse')),
                    // Ajoutez d'autres colonnes ici
                  ],
                  rows: orders.map((order) {
                    return DataRow(cells: [
                      DataCell(Text(order['OrderId'].toString())),
                      DataCell(Text(order['Customer'])),
                      DataCell(Text(order['Date'])),
                      DataCell(Text(order['Caisse'])),
                      // Ajoutez d'autres cellules ici
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
