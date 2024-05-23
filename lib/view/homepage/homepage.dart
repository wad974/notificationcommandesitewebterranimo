import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/view/footer.dart';
import 'package:notification_app_woocommerce/view/header.dart';

import 'package:notification_app_woocommerce/view/homepage/orders/liste_de_tout_commande.dart';

import 'package:notification_app_woocommerce/widget/drawer/drawerpage.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchDataOrders();
  }

  //init http
  List dataList = [];
  late List<bool> selected;
  late List<bool> btnTransmission;
  late List<bool> btnSaisiCaisse;
  late List<bool> btnCommandePret;
  late List<bool> btnCommandeEnvoyer;

  Future fetchDataOrders() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://192.168.1.22:1111/commandes/'));

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        setState(() {
          dataList = json.decode(response.body);
          selected = List<bool>.generate(dataList.length, (index) => false);
          btnSaisiCaisse =
              List<bool>.generate(dataList.length, (index) => false);
          btnCommandePret =
              List<bool>.generate(dataList.length, (index) => false);
          btnCommandeEnvoyer =
              List<bool>.generate(dataList.length, (index) => false);
          btnTransmission =
              List<bool>.generate(dataList.length, (index) => false);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    //on recuperer les données de navigator.pushNamed
    final String loginName =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      // on prend toute la page avec 2 row
      body: Column(
        children: [
          //barre header + name
          Header(loginName: loginName),

          //contenu body
          Expanded(
            child: Row(
              children: [
                // un drawer fixe
                const DrawerPage(),
                // un expanded
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TITRE COMMANDES
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 50.0),
                        height: 100,
                        child: const Text(
                          'Commandes',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // DIV recherche champ input +  body list  de tous les commandes
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(50),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: const Border(
                                    right: BorderSide(width: 1),
                                    top: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                    left: BorderSide(width: 1)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //champ input rechercher
                                Container(
                                  padding: EdgeInsets.only(left: 40, top: 10),
                                  height: 100,
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(Icons.search),
                                        labelText: 'Recherche'),
                                  ),
                                ),

                                // liste de tous les commandes
                                dataList.isEmpty
                                    // on affiche un indicateur de charge si list eszt vide
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    //sinon
                                    : ListAllOrders(
                                        dataList: dataList,
                                        btnCommandeEnvoyer: btnCommandeEnvoyer,
                                        btnCommandePret: btnCommandePret,
                                        btnSaisiCaisse: btnSaisiCaisse,
                                        btnTransmission: btnTransmission,
                                        loginName: loginName,
                                      )
                              ],
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
