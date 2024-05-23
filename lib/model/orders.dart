// import 'package:sqflite/sqflite.dart';

class Orders {
  final int id;
  final String nom;
  final String prenom;
  final String date;
  final String methodeDeLivraison;
  final bool transmissionResponsable;
  final bool saisieEnCaisse;
  final bool commandePrete;
  final bool commandeEnvoyerRetirer;
  final String nomDuResponsableEnCharge;

  const Orders({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.date,
    required this.methodeDeLivraison,
    required this.transmissionResponsable,
    required this.saisieEnCaisse,
    required this.commandePrete,
    required this.commandeEnvoyerRetirer,
    required this.nomDuResponsableEnCharge,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'date': date,
      'methodeDeLivraison': methodeDeLivraison,
      'transmissionResponsable': transmissionResponsable ? 1 : 0,
      'saisieEnCaisse': saisieEnCaisse ? 1 : 0,
      'commandePrete': commandePrete ? 1 : 0,
      'commandeEnvoyerRetirer': commandeEnvoyerRetirer ? 1 : 0,
      'nomDuResponsableEnCharge': nomDuResponsableEnCharge,
    };
  }

  @override
  String toString() {
    return 'Orders{ id: $id, nom: $nom, prenom: $prenom, date: $date, methodeDeLivraison: $methodeDeLivraison, transmissionResponsable: $transmissionResponsable, saisieEnCaisse: $saisieEnCaisse, commandePrete: $commandePrete, commandeEnvoyerRetirer : $commandeEnvoyerRetirer, nomDuResponsableEnCharge: $nomDuResponsableEnCharge }';
  }
}
