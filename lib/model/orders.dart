// import 'package:sqflite/sqflite.dart';

class Orders {
  final int id;
  final String nom;
  final String prenom;
  final String date;
  final String methodeDeLivraison;
  final int transmissionResponsable;
  final int saisieEnCaisse;
  final int commandePrete;
  final int commandeEnvoyerRetirer;
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
      'transmissionResponsable': transmissionResponsable,
      'saisieEnCaisse': saisieEnCaisse,
      'commandePrete': commandePrete,
      'commandeEnvoyerRetirer': commandeEnvoyerRetirer,
      'nomDuResponsableEnCharge': nomDuResponsableEnCharge,
    };
  }

  @override
  String toString() {
    return 'Orders{ id: $id, nom: $nom, prenom: $prenom, date: $date, methodeDeLivraison: $methodeDeLivraison, transmissionResponsable: $transmissionResponsable, saisieEnCaisse: $saisieEnCaisse, commandePrete: $commandePrete, commandeEnvoyerRetirer : $commandeEnvoyerRetirer, nomDuResponsableEnCharge: $nomDuResponsableEnCharge }';
  }
}
