// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/view/footer.dart';
import 'package:notification_app_woocommerce/view/header.dart';

import 'package:notification_app_woocommerce/view/homepage/orders/liste_de_tout_commande.dart';

import 'package:notification_app_woocommerce/widget/drawer/drawerpage.dart';

import '../../Controller/database.dart';
import '../../model/orders.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //notification windows uniquement
  List siCommandeExiste = [];

  //init http
  late String erreurCode;
  bool isLoadingErreur = false;
  List dataList = [];
  List matchIDs = [];
  List<bool> selected = [];
  List<bool> btnTransmission = [];
  List<bool> btnSaisiCaisse = [];
  List<bool> btnCommandePret = [];
  List<bool> btnCommandeEnvoyer = [];
  List loginNameArchive = [];
  late String loginName;
  //database sqlite
  DataBase db = DataBase();
  List archivesOrders = [];

  @override
  void initState() {
    super.initState();
    fetchDataOrders();
    db.openSql().then((context) => fetchArchivesOrders());

    //notification
    verificationNouveauCommande();
  }

  Future<void> fetchDataOrders() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://192.168.1.28:1111/commandes'));

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        setState(() {
          dataList = json.decode(response.body);
          //verification pour notification
          print(dataList[0]['status']);

          loginName = ModalRoute.of(context)!.settings.arguments.toString();

          // list pour recuperer les commandes déjà archivé
          // et vérifié avec les commandes charger
          List<int> dataListID = dataList.map((e) => e['id'] as int).toList();

          List archivesOrdersID = archivesOrders.map((e) => e.id).toList();

          matchIDs =
              dataListID.where((id) => archivesOrdersID.contains(id)).toList();

          selected = List<bool>.generate(dataList.length, (index) => false);
          btnTransmission =
              List<bool>.generate(dataList.length, (index) => false);
          btnSaisiCaisse =
              List<bool>.generate(dataList.length, (index) => false);
          btnCommandePret =
              List<bool>.generate(dataList.length, (index) => false);
          btnCommandeEnvoyer =
              List<bool>.generate(dataList.length, (index) => false);

          // on récupere les boutons qui est sois déjà validé ou pas dans archives
          // avec la boucle foreach
          dataList.asMap().forEach((index, value) {
            print('id dalatlist : ${value['id']}');
            print('id MAtchlist : $matchIDs');

            if (matchIDs.contains(value['id'])) {
              archivesOrders.asMap().forEach((key, value) {
                if (value.transmissionResponsable == 1) {
                  btnTransmission[key] = true;
                } else if (value.saisieEnCaisse == 1) {
                  btnSaisiCaisse[key] = true;
                } else if (value.commandePrete == 1) {
                  btnCommandePret[key] = true;
                }
              });
              btnCommandeEnvoyer[index] = true;
            }
          });
        });
      }
    } catch (e) {
      setState(() {
        isLoadingErreur = true;
        erreurCode = e.toString();
      });
      // rethrow;
    }
  }

  //fetcharchivesorders
  Future<void> fetchArchivesOrders() async {
    List<Orders> orders = await db.listesCommandesArchivers();
    setState(() {
      archivesOrders = orders;
    });
  }

  //shownotificationwindow
  //bloc notification
  Future<void> notificationWindows(String title, String body) async {
    final notification = WindowsNotification(applicationId: "www.terranimo.re");
    NotificationMessage message = NotificationMessage.fromPluginTemplate(
      "Terranimo",
      title,
      body,
    );

    await notification.showNotificationPluginTemplate(message);
  }

  Future<void> fetchNewDataOrders() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://192.168.1.28:1111/commandes'));
      if (response.statusCode == 200) {
        siCommandeExiste = json.decode(response.body);
        print('id pour siCommandeExiste : ${siCommandeExiste[0]['id']}');
        print('id pour datalist : ${dataList[0]['id']}');

        if (siCommandeExiste[0]['id'] > dataList[0]['id']) {
          // Nouvelle commande détectée
          notificationWindows('Nouvelle', 'Une nouvelle commandes passé');
        }
      }
    } catch (e) {
      print('erreur lors du timerhttp : $e');
    }
  }

  //timer
  void verificationNouveauCommande() {
    const duration = Duration(minutes: 10); // intervalle de seconde
    Timer.periodic(duration, (timer) => fetchNewDataOrders());
  }
  /////
  ///FIN BLOC NOTIF

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
                DrawerPage(loginName: loginName),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //champ input rechercher
                                // Container(
                                //   padding: EdgeInsets.only(left: 40, top: 10),
                                //   height: 100,
                                //   width: 500,
                                //   child: TextFormField(
                                //     decoration: const InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         icon: Icon(Icons.search),
                                //         labelText: 'Recherche'),
                                //   ),
                                // ),

                                // liste de tous les commandes
                                isLoadingErreur == true
                                    ? Center(
                                        child: Text(
                                        erreurCode,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ))
                                    : dataList.isEmpty
                                        // on affiche un indicateur de charge si list eszt vide
                                        ? const Center(
                                            child: Column(
                                            children: [
                                              CircularProgressIndicator(),
                                              // SizedBox(
                                              //   height: 20,
                                              // ),
                                              // ElevatedButton(
                                              //     onPressed: () {
                                              //       fetchDataOrders();
                                              //     },
                                              //     child: const Text(
                                              //         'Charger les commandes'))
                                            ],
                                          ))
                                        //sinon

                                        : ListAllOrders(
                                            dataList: dataList,
                                            matchIDs: matchIDs,
                                            btnCommandeEnvoyer:
                                                btnCommandeEnvoyer,
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
