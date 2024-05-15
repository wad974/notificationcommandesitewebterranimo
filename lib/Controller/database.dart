// ignore_for_file: unused_field

import 'package:hive/hive.dart';

class LoginDataBase {
  // on creer un list d'utilisateur tab[]
  List userLogin = [];

  // reference box
  final _myBox = Hive.openBox('myBox');
  
}
