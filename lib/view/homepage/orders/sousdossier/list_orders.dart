// ignore_for_file: avoid_print, unnecessary_null_comparison

//import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_app_woocommerce/Controller/http.dart';

class listOrders extends StatefulWidget {
  const listOrders({super.key});

  @override
  State<listOrders> createState() => _listOrdersState();
}

class _listOrdersState extends State<listOrders> {
  static const List numOrders = [];
  List<bool> selected = List<bool>.generate(numOrders.length, (index) => false);

  // on recupere GET orders
  final http = fetchDataOrders();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: http,
            builder: (context, index) {
              if (index.connectionState == ConnectionState.waiting) {
                // si l'état de la connexion est wait alors on affiche
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        width: 1000,
                        height: 500,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()));
              } else {
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Nom')),
                    DataColumn(label: Text('Prenom')),
                    DataColumn(label: Text('Date commande')),
                    DataColumn(label: Text('Livraison')),
                    DataColumn(label: Text('Status Commande')),
                    // DataColumn(label: Text('Transmission Responsable')),
                    // DataColumn(label: Text('Saisie en caisse')),
                    // DataColumn(label: Text('Commande Prete')),
                    // DataColumn(label: Text('Commande Envoyer / Retirer')),
                    // DataColumn(label: Text('Nom du responsable')),
                  ],
                  rows: index.data.map<DataRow>((order) {
                    return DataRow(
                      cells: [
                        DataCell(Text(order['id'].toString())),
                        DataCell(Text(order['nom'])),
                        DataCell(Text(order['prenom'])),
                        DataCell(Text(order['date'].toString())),
                        DataCell(Text(order['adresse'])),
                        DataCell(Text(order['status'])),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
          // child: DataTable(
          //   columnSpacing: 15,
          //   headingTextStyle: const TextStyle(color: Colors.white),
          //   headingRowColor:
          //       MaterialStateColor.resolveWith((states) => Colors.red.shade800),
          //   //border: const TableBorder(bottom: BorderSide(width: 1.0)),
          //   columns: const <DataColumn>[
          //     DataColumn(label: Text('ID')),
          //     DataColumn(label: Text('Nom')),
          //     DataColumn(label: Text('Prenom')),
          //     DataColumn(label: Text('Date')),
          //     DataColumn(label: Text('Livraison')),
          //     DataColumn(label: Text('Transmission Responsable')),
          //     DataColumn(label: Text('Saisie en caisse')),
          //     DataColumn(label: Text('Commande Prete')),
          //     DataColumn(label: Text('Commande Envoyer / Retirer')),
          //     DataColumn(label: Text('Nom du responsable')),
          //   ],
          //   rows: (
          //     numOrders.length,
          //     (index) => DataRow(
          //       cells: <DataCell>[
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //         DataCell(Text('Row $index')),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
