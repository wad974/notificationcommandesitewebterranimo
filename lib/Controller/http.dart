// // ignore_for_file: unnecessary_brace_in_string_interps

// import 'dart:convert';
// //import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future fetchDataLogin() async {
//   try {
//     http.Response response =
//         await http.get(Uri.parse('http://192.168.1.22:1111/getlogin/'));

//     if (response.statusCode == 200) {
//       print('reponse.body : ${response.body}');
//       return json.decode(response.body).toString();
//     }
//   } catch (e) {
//     rethrow;
//   }
// }

// Future fetchDataOrders() async {
//   try {
//     http.Response response =
//         await http.get(Uri.parse('http://192.168.1.22:1111/commandes/'));

//     if (response.statusCode == 200) {
//       // print(json.decode(response.body));
//       return json.decode(response.body);
//     } else {
//       return  const Text('Pas de commandes');
//     }
//   } catch (e) {
//     rethrow;
//   }
// }
