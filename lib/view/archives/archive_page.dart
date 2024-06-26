import 'package:flutter/material.dart';

import 'package:notification_app_woocommerce/view/footer.dart';

import '../../widget/drawer/drawerpage.dart';
import '../header.dart';
import 'sousdossier/list_archives_orders.dart';

class ArchivesPage extends StatefulWidget {
  static String routeName = 'archives';
  const ArchivesPage({super.key});

  @override
  State<ArchivesPage> createState() => _ArchivesPageState();
}

class _ArchivesPageState extends State<ArchivesPage> {
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

                //TITRE ARCHIVES + LISTES
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TITRE
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 50.0),
                        height: 100,
                        child: const Text(
                          'Archives',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // ici listes de tous les commandes validés par user
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ArchivesOrdersList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // footer
          Footer(),
        ],
      ),
    );
  }
}
