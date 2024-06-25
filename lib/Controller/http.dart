import 'dart:convert';

import 'package:http/http.dart' as http;

class RequeteHttp {
  List message = [];
  late String baseUrl = '';

  // function recup commande depuis api python
  void updateBaseUrl(url) {
    baseUrl = url;
  }

  //function post lien api
  Future<void> postUrlApi(String baseUrl, String url) async {
    print('y as quoi dedans : $url');
    baseUrl = baseUrl;

    final response = await http.post(
      Uri.parse('$baseUrl/urlApi'),
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
  Future<void> updateStatusCommandePret(
      String baseUrl, String status, int id) async {
    baseUrl = baseUrl;
    final response = await http.put(
      Uri.parse('$baseUrl/updateStatus'),
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
