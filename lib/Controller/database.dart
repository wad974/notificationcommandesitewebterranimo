// ignore_for_file: unused_field, depend_on_referenced_packages, unnecessary_import

import 'package:flutter/widgets.dart';
// import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../model/orders.dart';

// class LoginDataBase {
//   final _myBox = Hive.openBox('myBox');
// }

class DataBase {
  late Orders _orders;
  // Variable pour stocker l'instance de la base de données
  late Database _database;

  // function ouverture sql
  Future<void> openSql() async {
    // Initialiser sqflite pour l'utilisation avec ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    // Import package widget.dart
    WidgetsFlutterBinding.ensureInitialized();

    // Path dababase
    String path = join(await getDatabasesPath(), 'orders_database.db');
    // Ouvrir la base de données
    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE orders(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, date TEXT, methodeDeLivraison TEXT, transmissionResponsable INTEGER, saisieEnCaisse INTEGER, commandePrete INTEGER, commandeEnvoyerRetirer INTEGER, nomDuResponsableEnCharge TEXT)',
        );
      },
      version: 1,
    );
  }

  // Fonction insertSQL
  Future<void> insertOrders(Orders orders) async {
    await _database.insert(
      'orders',
      orders.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fonction pour récupérer les commandes archivées
  Future<List<Orders>> listesCommandesArchivers() async {
    final List<Map<String, Object?>> ordersMaps =
        await _database.query('orders');

    // Convertir la liste en object
    return [
      for (final {
            'id': id as int,
            'nom': nom as String,
            'prenom': prenom as String,
            'date': date as String,
            'methodeDeLivraison': methodeDeLivraison as String,
            'transmissionResponsable': transmissionResponsable as bool,
            'saisieEnCaisse': saisieEnCaisse as bool,
            'commandePrete': commandePrete as bool,
            'commandeEnvoyerRetirer': commandeEnvoyerRetirer as bool,
            'nomDuResponsableEnCharge': nomDuResponsableEnCharge as String,
          } in ordersMaps)
        Orders(
          id: id,
          nom: nom,
          prenom: prenom,
          date: date,
          methodeDeLivraison: methodeDeLivraison,
          transmissionResponsable: transmissionResponsable,
          saisieEnCaisse: saisieEnCaisse,
          commandePrete: commandePrete,
          commandeEnvoyerRetirer: commandeEnvoyerRetirer,
          nomDuResponsableEnCharge: nomDuResponsableEnCharge,
        ),
    ];
  }
}
