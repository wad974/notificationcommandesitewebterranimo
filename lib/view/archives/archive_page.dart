import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/drawer/drawerpage.dart';
import '../header.dart';

class ArchivesPage extends StatelessWidget {
  static String routeName = 'archives';
  const ArchivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    //on recuperer les données de navigator.pushNamed
    final String loginName =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Column(
        children: [
          // header
          Header(loginName: loginName),

          //contenu body
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //drawers
                DrawerPage(loginName: loginName),

                //TITRE ARCHIVES
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 50.0),
                  height: 100,
                  child: const Text(
                    'Archives',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),

                // ici listes de tous les commandes validés par user

                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
