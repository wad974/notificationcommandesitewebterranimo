// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:notification_app_woocommerce/Controller/http.dart';

// class listOrders extends StatefulWidget {
//   final String nomLogin;
//   const listOrders({super.key, required this.nomLogin});

//   @override
//   State<listOrders> createState() => _listOrdersState();
// }

// class _listOrdersState extends State<listOrders> {
//   //bouton transmission
//   bool? valeurTransmission = false;

//   // on recupere GET orders
//   //http
//   // Http http = Http();

//   @override
//   void initState() {
//     super.initState();
//     fetchDataOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 650,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       alignment: Alignment.topLeft,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: FutureBuilder(
//             future: fetchDataOrders(),
//             builder: (context, index) {
//               if (index.connectionState == ConnectionState.waiting) {
//                 // si l'état de la connexion est wait alors on affiche
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 return DataTable(
//                   columnSpacing: 10,
//                   showBottomBorder: true,
//                   headingTextStyle: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                   headingRowColor: const MaterialStatePropertyAll(
//                       Color.fromRGBO(192, 69, 61, 1)),
//                   columns: const <DataColumn>[
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                           child: Text('ID', textAlign: TextAlign.center)),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                             child: Center(
//                                 child:
//                                     Text('Nom', textAlign: TextAlign.center)))),
//                     DataColumn(
//                         label: Expanded(
//                             child: Center(
//                                 child: Text('Prenom',
//                                     textAlign: TextAlign.center)))),
//                     DataColumn(
//                         label: Expanded(
//                             child: Center(
//                                 child: Text('Date',
//                                     textAlign: TextAlign.center)))),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child: Text('Methode de Livraison',
//                             textAlign: TextAlign.center),
//                       ),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child: Text('Transmission Responsable',
//                             textAlign: TextAlign.center),
//                       ),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child: Text('Saisie en caisse',
//                             textAlign: TextAlign.center),
//                       ),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child:
//                             Text('Commande Prete', textAlign: TextAlign.center),
//                       ),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child: Text('Commande \n Envoyer / Retirer',
//                             textAlign: TextAlign.center),
//                       ),
//                     )),
//                     DataColumn(
//                         label: Expanded(
//                       child: Center(
//                         child: Text('Nom du responsable',
//                             textAlign: TextAlign.center),
//                       ),
//                     )),
//                   ],
//                   rows: index.data.map<DataRow>((order) {
//                     bool? value = false;
//                     return DataRow(
//                       cells: [
//                         //id
//                         DataCell(Text(order['id'].toString(),
//                             textAlign: TextAlign.center)),
//                         //nom
//                         DataCell(
//                             Text(order['nom'], textAlign: TextAlign.center)),
//                         //prenom
//                         DataCell(
//                             Text(order['prenom'], textAlign: TextAlign.center)),
//                         //date
//                         DataCell(Text(order['date'].toString(),
//                             textAlign: TextAlign.center)),
//                         //livraison
//                         DataCell(Text(order['adresse'],
//                             textAlign: TextAlign.center)),
//                         //transmission responsable
//                         DataCell(
//                           Expanded(
//                             child: Center(
//                               child: Checkbox(
//                                 value: value,
//                                 onChanged: (bool? newValeur) {
//                                   setState(() {
//                                     value = newValeur!;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         //saisie en caisse
//                         DataCell(Expanded(
//                             child: Center(
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.check_box_outline_blank,
//                                 color: Color.fromRGBO(192, 69, 61, 1),
//                               )),
//                         ))),
//                         //commande prete
//                         DataCell(Expanded(
//                             child: Center(
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.check_box_outline_blank,
//                                 color: Color.fromRGBO(192, 69, 61, 1),
//                               )),
//                         ))),
//                         //commande envoyer
//                         DataCell(Expanded(
//                             child: Center(
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.check_box_outline_blank,
//                                 color: Color.fromRGBO(192, 69, 61, 1),
//                               )),
//                         ))),
//                         //nom responsable
//                         DataCell(Expanded(
//                             child: Center(
//                                 child: Text(widget.nomLogin,
//                                     textAlign: TextAlign.center)))),
//                       ],
//                     );
//                   }).toList(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
