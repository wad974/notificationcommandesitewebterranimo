// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/view/homepage/orders/sousdossier/dialog_bouton.dart';

class ListAllOrders extends StatefulWidget {
  late List dataList;
  late List<bool> btnTransmission;
  late List<bool> btnSaisiCaisse;
  late List<bool> btnCommandePret;
  late List<bool> btnCommandeEnvoyer;

  ListAllOrders({
    super.key,
    required this.dataList,
    required this.btnCommandeEnvoyer,
    required this.btnCommandePret,
    required this.btnSaisiCaisse,
    required this.btnTransmission,
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
                      headingRowColor: MaterialStateProperty.all(
                          const Color.fromRGBO(192, 69, 61, 1)),
                      columns: const [
                        //id
                        DataColumn(label: Text('ID')),
                        //nom
                        DataColumn(label: Text('Nom')),
                        //prenom
                        DataColumn(label: Text('Prenom')),
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
                            label: Center(
                          child: Text(
                            'Methode\n de Livraison',
                            textAlign: TextAlign.center,
                          ),
                        )),
                        //Transmission
                        DataColumn(label: Text('Transmission Responsable')),
                        //saisi
                        DataColumn(label: Text('Saisie en caisse')),
                        //commande
                        DataColumn(label: Text('Commande Prete')),
                        //envoyer
                        DataColumn(label: Text('Commande\n Envoyer / Retirer')),
                        //Nom Responsable
                        DataColumn(
                            label: Expanded(
                          child: Center(
                            child: Text(
                              'Nom\n du responsable',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                      ],
                      rows: List.generate(widget.dataList.length, (index) {
                        return DataRow(
                          cells: [
                            //id
                            DataCell(
                                Text(widget.dataList[index]['id'].toString())),
                            //nom
                            DataCell(Text(widget.dataList[index]['nom'])),
                            //prenom
                            DataCell(Text(widget.dataList[index]['prenom'])),
                            //date
                            DataCell(Text(
                                widget.dataList[index]['date'].toString())),
                            //livraion
                            DataCell(Text(widget.dataList[index]['nom'])),
                            //transmission
                            DataCell(IconButton(
                                icon: widget.btnTransmission[index] == false
                                    ? const Icon(Icons.check_box_outline_blank)
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                onPressed: () {
                                  showBoutonTransmission(index);
                                })),
                            //Saisie caisse
                            DataCell(IconButton(
                                icon: widget.btnSaisiCaisse[index] == false
                                    ? const Icon(Icons.check_box_outline_blank)
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                onPressed: () {
                                  showBoutonSaisiCaisse(index);
                                })),
                            //Commande prete
                            DataCell(IconButton(
                                icon: widget.btnCommandePret[index] == false
                                    ? const Icon(Icons.check_box_outline_blank)
                                    : const Icon(Icons.check),
                                onPressed: () {
                                  setState(() {
                                    widget.btnCommandePret[index] =
                                        !widget.btnCommandePret[index];
                                  });
                                })),
                            //Commande Envoyer
                            DataCell(IconButton(
                                icon: widget.btnCommandeEnvoyer[index] == false
                                    ? const Icon(Icons.check_box_outline_blank)
                                    : const Icon(Icons.check),
                                onPressed: () {
                                  setState(() {
                                    widget.btnCommandeEnvoyer[index] =
                                        !widget.btnCommandeEnvoyer[index];
                                  });
                                })),
                            //Nom responsable
                            DataCell(Text(widget.dataList[index]['nom'])),
                          ],
                        );
                      }),
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
