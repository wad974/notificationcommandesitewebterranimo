import 'package:flutter/material.dart';

class FormApiPython extends StatelessWidget {
  String urlApiPython;
  final GlobalKey formApiKey;
  final TextEditingController input;
  Function valideFormApiPython;
  FormApiPython({
    super.key,
    required this.urlApiPython,
    required this.formApiKey,
    required this.input,
    required this.valideFormApiPython,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formApiKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // div url api
            Container(
              height: 75,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // champ api
                  Container(
                    width: 700,
                    child: TextFormField(
                      style: TextStyle(fontSize: 17),
                      controller: input,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'API PYTHON',
                        icon: Icon(Icons.link),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Merci de remplir l'adresse de l'API";
                        }
                        return null;
                      },
                    ),
                  ),

                  // champ bouton
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(200, 60)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(192, 69, 61, 1)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          valideFormApiPython();
                        },
                        child: const Text('Enregistre')),
                  ),
                ],
              ),
            ),

            //on affiche les parametre déjà enregistrer
            Container(
              child: Text(
                'URL API PYTHON : ${urlApiPython}',
              ),
            ),
          ],
        ));
  }
}
