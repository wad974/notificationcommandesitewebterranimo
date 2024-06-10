import 'dart:convert';

import 'package:http/http.dart' as http;

class RequeteHttp {
  List message = [];
  String baseUrl = '';

  // function recup commande depuis api python
  

  //function post lien api
  Future<void> postUrlApi(String url) async {
    print('y as quoi dedans : $url');

    final response = await http.post(
      Uri.parse('http://192.168.1.28:1111/urlApi'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(
        {
          'url': url,
        },
      ),
    );

    if (response.statusCode == 200) {
      message = jsonDecode(response.body);
    } else {
      print('erreur lors du post');
    }
  }

  //function future update commandePrete
  Future<void> updateStatusCommandePret(String status, int id) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.28:1111/updateStatus'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'status': status,
        'id': id,
      }),
    );

    //conditions if erreur
    if (response.statusCode == 200) {
      print(response.body);
      message = json.decode(response.body);
    } else {
      throw Exception('Erreur lors la mise à jour du status');
    }
  }
}
