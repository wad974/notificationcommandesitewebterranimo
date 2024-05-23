import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Controller/database.dart';
import '../../../model/orders.dart';

class ArchivesOrdersList extends StatefulWidget {
  const ArchivesOrdersList({super.key});

  @override
  State<ArchivesOrdersList> createState() => _ArchivesOrdersListState();
}

class _ArchivesOrdersListState extends State<ArchivesOrdersList> {
  //db
  DataBase db = DataBase();
  late Orders orders;
  List archivesOrders = [];

  @override
  void initState() {
    super.initState();
    db.openSql().then((context) => fetchArchivesOrders());
  }

  Future fetchArchivesOrders() async {
    List<Orders> orders = await db.listesCommandesArchivers();
    setState(() {
      archivesOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: DataTable(
                      dataRowColor:
                          MaterialStateProperty.all(Colors.grey.shade200),
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
                          ),
                        ),
                        //nom
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Nom',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //prenom
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Prenom',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
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
                          ),
                        ),
                        //Transmission
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Transmission\n Responsable',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //saisi
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Saisie en\n caisse',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //commande
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Commande\n Prete',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //envoyer
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Commande\n Envoyer / Retirer',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        //Nom Responsable
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Nom du\n responsable',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        archivesOrders.length,
                        (index) {
                          print('liste generé : $index');
                          return DataRow(
                            cells: [
                              DataCell(Center(
                                  child: Text(
                                      archivesOrders[index].id.toString()))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index].nom))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index].prenom))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index].date))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .methodeDeLivraison))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .transmissionResponsable
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .saisieEnCaisse
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .commandePrete
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .commandeEnvoyerRetirer
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .nomDuResponsableEnCharge))),
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
