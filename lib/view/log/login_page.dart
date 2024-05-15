// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import 'sous_dossier/form_login.dart';

class LoginPage extends StatelessWidget {
  static String routeName = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // partie gauche ecran Image
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Ink(
                        child: const Image(
                          image: AssetImage('assets/images/terranimo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          // partie droite ecran Login
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.red.shade900,
              child: const Center(
                child: FormLogin(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
