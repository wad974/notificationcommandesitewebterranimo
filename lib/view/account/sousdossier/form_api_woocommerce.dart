// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FormApiWooCommerce extends StatelessWidget {
  String urlApiWooCommerce;
  final GlobalKey formKey;
  final TextEditingController input;
  Function valideForm;
  FormApiWooCommerce({
    super.key,
    required this.urlApiWooCommerce,
    required this.formKey,
    required this.input,
    required this.valideForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        labelText: 'API WOOCOMMERCE',
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
                          valideForm();
                        },
                        child: const Text('Enregistre')),
                  ),
                ],
              ),
            ),

            //on affiche les parametre déjà enregistrer
            Container(
              child: Text('URL API WOOCOMMERCE : ${urlApiWooCommerce}'),
            ),
          ],
        ));
  }
}
