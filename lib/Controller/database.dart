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

    // Ouvrir la base de données
    _database = await openDatabase(
      join(await getDatabasesPath(), 'orders_database.db'),
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
    print("Commande inserer: ${orders.toMap()}");
  }

  // Fonction pour récupérer les commandes archivées
  Future<List<Orders>> listesCommandesArchivers() async {
    final List<Map<String, Object?>> ordersMaps =
        await _database.query('orders');
    // print("Recupere tous les commandes: $ordersMaps");
    // Convertir la liste en object
    return [
      for (final {
            'id': id as int,
            'nom': nom as String,
            'prenom': prenom as String,
            'date': date as String,
            'methodeDeLivraison': methodeDeLivraison as String,
            'transmissionResponsable': transmissionResponsable as int,
            'saisieEnCaisse': saisieEnCaisse as int,
            'commandePrete': commandePrete as int,
            'commandeEnvoyerRetirer': commandeEnvoyerRetirer as int,
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

  // function delete
  Future<void> deleteOrders(int id) async {
    print('id delete : $id');
    try {
      final db = await _database;
      await db.delete(
        'orders',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('numéros de la ligne supprimer: $db');
    } catch (e) {
      print('Erreur lors de la suprresion: $e');
    }
  }
}
