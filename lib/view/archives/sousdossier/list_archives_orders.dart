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
  List<bool> selected = [];

  @override
  void initState() {
    super.initState();
    db.openSql().then((context) => fetchArchivesOrders());
  }

  Future fetchArchivesOrders() async {
    List<Orders> orders = await db.listesCommandesArchivers();

    setState(() {
      archivesOrders = orders;
      selected = List<bool>.generate(archivesOrders.length, (index) => false);
    });
  }

  // function delete archives
  Future<void> deleteArchivesOrder(value, id, index) async {
    // final idASupprimer = archivesOrders[index].id;
    final resultat = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'annuler');
                    },
                    child: Text('annuler')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Supprimer');
                  },
                  child: Text('Supprimer'),
                ),
              ],
            ),
          );
        });

    if (resultat == 'Supprimer') {
      // database function delete
      setState(() {
        // selected[index] = !selected[index];
        db.deleteOrders(id);
        archivesOrders.removeAt(index);
        selected.removeAt(index);
      });
    }
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
                      sortAscending: false,
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
                              DataCell(
                                Center(
                                  child: archivesOrders[index]
                                              .transmissionResponsable ==
                                          1
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child:
                                      archivesOrders[index].saisieEnCaisse == 1
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child:
                                      archivesOrders[index].commandePrete == 1
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                ),
                              ),
                              DataCell(Center(
                                child: archivesOrders[index].commandePrete == 1
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                              )),
                              DataCell(Center(
                                  child: Text(archivesOrders[index]
                                      .nomDuResponsableEnCharge))),
                            ],
                            selected: selected[index],
                            onSelectChanged: (value) {
                              int id = archivesOrders[index].id;
                              deleteArchivesOrder(value, id, index);
                            },
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
