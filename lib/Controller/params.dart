// ignore_for_file: unnecessary_import, avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../model/config_param.dart';

class ParamsDatabase {
  //init dabase
  late Database _db;

  Future<void> openSqlParams() async {
    // Initialiser sqflite pour l'utilisation avec ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    // Import package widget.dart
    WidgetsFlutterBinding.ensureInitialized();

    // Ouvrir la base de données
    _db = await openDatabase(
      join(await getDatabasesPath(), 'params_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE params(id INTEGER PRIMARY KEY, url TEXT)',
        );
      },
      version: 1,
    );
  }

  // Fonction insertSQL
  Future<void> insertParams(Params params) async {
    await _db.insert(
      'params',
      params.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("URL API  inserer: ${params.toMap()}");
  }

  // Fonction pour récupérer les commandes archivées
  Future<List<Params>> listesParamsArchivers() async {
    final List<Map<String, Object?>> paramsMaps = await _db.query('params');
    // print("Recupere tous les commandes: $paramsMaps");
    // Convertir la liste en object
    return [
      for (final {
            'id': id as int,
            'url': url as String,
          } in paramsMaps)
        Params(
          id: id,
          url: url,
        ),
    ];
  }
}
