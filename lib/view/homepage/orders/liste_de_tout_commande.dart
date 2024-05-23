// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/Controller/database.dart';
import 'package:notification_app_woocommerce/model/orders.dart';
import 'package:notification_app_woocommerce/view/homepage/orders/sousdossier/dialog_bouton.dart';

class ListAllOrders extends StatefulWidget {
  late List dataList;
  late List<bool> btnTransmission;
  late List<bool> btnSaisiCaisse;
  late List<bool> btnCommandePret;
  late List<bool> btnCommandeEnvoyer;
  String loginName;

  ListAllOrders({
    super.key,
    required this.dataList,
    required this.btnCommandeEnvoyer,
    required this.btnCommandePret,
    required this.btnSaisiCaisse,
    required this.btnTransmission,
    required this.loginName,
  });

  @override
  State<ListAllOrders> createState() => _ListAllOrdersState();
}

class _ListAllOrdersState extends State<ListAllOrders> {
  //showBoutonTransmission
  void showBoutonTransmission(index) async {
    final resultat = await showDialog(
        context: context,
        builder: (context) {
          return DialogBouton(
            index: index,
            btn: widget.btnTransmission,
          );
        });
    if (resultat == 'sauvegarder') {
      setState(() {
        widget.btnTransmission[index] = !widget.btnTransmission[index];
      });
    }
  }

  //showBoutonSaisiCaisse
  void showBoutonSaisiCaisse(index) async {
    final resultat = await showDialog(
        context: context,
        builder: (context) {
          return DialogBouton(
            index: index,
            btn: widget.btnSaisiCaisse,
          );
        });
    if (resultat == 'sauvegarder') {
      setState(() {
        widget.btnSaisiCaisse[index] = !widget.btnSaisiCaisse[index];
      });
    }
  }

  // bouton Commande Envoyer
  void showCommandeEnvoyerRetirer(
      int index,
      int id,
      String nom,
      String prenom,
      String date,
      String methodeDeLivraison,
      int transmissionResponsable,
      int saisieEnCaisse,
      int commandePrete,
      int commandeEnvoyerRetirer,
      String nomDuResponsableEnCharge) async {
    final resultat = await showDialog(
        context: context,
        builder: (context) {
          return DialogBoutonFinal(
            index: index,
            btn: widget.btnCommandeEnvoyer,
          );
        });
    if (resultat == 'sauvegarder') {
      WidgetsFlutterBinding.ensureInitialized();
      // partie a faire pour stocker dans la basse Sqlite
      //database appeler
      DataBase db = DataBase();
      await db.openSql();

      // instance orders archives à inserer
      var archivesCommandes = Orders(
          id: id,
          nom: nom,
          prenom: prenom,
          date: date,
          methodeDeLivraison: methodeDeLivraison,
          transmissionResponsable: transmissionResponsable,
          saisieEnCaisse: saisieEnCaisse,
          commandePrete: commandePrete,
          commandeEnvoyerRetirer: commandeEnvoyerRetirer,
          nomDuResponsableEnCharge: nomDuResponsableEnCharge);

      // et on insere l'archives
      await db.insertOrders(archivesCommandes);

      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Commande archivée avec succées',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      //fin partie
      setState(() {
        widget.btnCommandeEnvoyer[index] = !widget.btnCommandeEnvoyer[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DataTable(
                      showBottomBorder: true,
                      headingRowColor: MaterialStateProperty.all(
                          const Color.fromRGBO(192, 69, 61, 1)),
                      columns: const [
                        //id
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'ID',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //nom
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Nom',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //prenom
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Prenom',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //date
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Date',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //livraison
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Methode\n de Livraison',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //Transmission
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Transmission\n Responsable',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //saisi
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Saisie en\n caisse',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //commande
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Commande\n Prete',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        //envoyer
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: Text(
                          'Commande\n Envoyer / Retirer',
                          textAlign: TextAlign.center,
                        )))),
                        //Nom Responsable
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Nom du\n responsable',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                      ],
                      rows: List.generate(
                        widget.dataList.length,
                        (index) {
                          return DataRow(
                            color: MaterialStateProperty.resolveWith((states) {
                              if (widget.btnCommandeEnvoyer[index] == true) {
                                return const Color.fromRGBO(202, 196, 208, 1);
                              }
                            }),
                            cells: [
                              //id
                              DataCell(Center(
                                  child: Text(widget.dataList[index]['id']
                                      .toString()))),
                              //nom
                              DataCell(Center(
                                  child: Text(widget.dataList[index]['nom']))),
                              //prenom
                              DataCell(Center(
                                  child:
                                      Text(widget.dataList[index]['prenom']))),
                              //date
                              DataCell(Center(
                                child: Text(
                                    widget.dataList[index]['date'].toString()),
                              )),
                              //livraion
                              DataCell(Center(
                                  child: Text(widget.dataList[index]['nom']))),
                              //transmission
                              DataCell(Center(
                                child: widget.btnCommandeEnvoyer[index] == false
                                    ? IconButton(
                                        icon: widget.btnTransmission[index] ==
                                                false
                                            ? const Icon(
                                                Icons.check_box_outline_blank)
                                            : const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                        onPressed: () {
                                          showBoutonTransmission(index);
                                        })
                                    : widget.btnCommandePret[index] == false
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                              )),
                              //Saisie caisse
                              DataCell(Center(
                                child: widget.btnCommandeEnvoyer[index] == false
                                    ? IconButton(
                                        icon: widget.btnSaisiCaisse[index] ==
                                                false
                                            ? const Icon(
                                                Icons.check_box_outline_blank)
                                            : const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                        onPressed: () {
                                          showBoutonSaisiCaisse(index);
                                        })
                                    : widget.btnCommandePret[index] == false
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                              )),
                              //Commande prete
                              DataCell(Center(
                                child: widget.btnCommandeEnvoyer[index] == false
                                    ? IconButton(
                                        icon: widget.btnCommandePret[index] ==
                                                false
                                            ? const Icon(
                                                Icons.check_box_outline_blank)
                                            : const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            widget.btnCommandePret[index] =
                                                !widget.btnCommandePret[index];
                                          });
                                        })
                                    : widget.btnCommandePret[index] == false
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                              )),
                              //Commande Envoyer
                              DataCell(Center(
                                  child: widget.btnCommandeEnvoyer[index] ==
                                          false
                                      ? IconButton(
                                          icon: const Icon(
                                              Icons.check_box_outline_blank),
                                          onPressed: () {
                                            int boutonTransmission;
                                            widget.btnTransmission[index]
                                                ? boutonTransmission = 1
                                                : boutonTransmission = 0;
                                            int boutonSaisi;
                                            widget.btnSaisiCaisse[index]
                                                ? boutonSaisi = 1
                                                : boutonSaisi = 0;
                                            int boutonPret;
                                            widget.btnCommandePret[index]
                                                ? boutonPret = 1
                                                : boutonPret = 0;

                                            int boutonEnvoyer;
                                            widget.btnCommandeEnvoyer[index]
                                                ? boutonEnvoyer = 0
                                                : boutonEnvoyer = 1;

                                            showCommandeEnvoyerRetirer(
                                                index,
                                                widget.dataList[index]['id'],
                                                widget.dataList[index]['nom'],
                                                widget.dataList[index]
                                                    ['prenom'],
                                                widget.dataList[index]['date'],
                                                widget.dataList[index]['nom'],
                                                boutonTransmission,
                                                boutonSaisi,
                                                boutonPret,
                                                boutonEnvoyer,
                                                widget.loginName);
                                          })
                                      : const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 40,
                                        ))),
                              //Nom responsable
                              DataCell(Center(
                                child: Text(
                                  widget.loginName,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
