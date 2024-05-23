//import 'dart:html';

// ignore_for_file: must_be_immutable, unused_field, unnecessary_brace_in_string_interps, use_build_context_synchronously, avoid_print
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

// import 'package:hive/hive.dart';
import 'package:notification_app_woocommerce/view/homepage/homepage.dart';

import 'package:window_manager/window_manager.dart';

// import '../../../Controller/database.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> cleFormulaire = GlobalKey<FormState>();
  //on recupere saisie utilisateur
  final TextEditingController controllerLogin = TextEditingController();
  // //init nosql hive mybox
  // final _myBox = Hive.openBox('myBox');
  // //on recupere database pour stocker les logins de connexion
  // LoginDataBase db = LoginDataBase();

  //creation login pour stocker dans la dans un fichier TXT et recup args
  Future validationFormulaire() async {
    if (cleFormulaire.currentState!.validate()) {
      cleFormulaire.currentState!.save();

      // db.userLogin.add([controllerLogin.text]);
      // on appel la function pour stocker les nom utilisateur + date
      ecrireDonneesSiNecessaire(controllerLogin.text);

      //on utilise navigator pushNamed
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: RouteSettings(
            arguments: controllerLogin.text,
          ),
        ),
      );
    }
  }

  //function bouton quitter application
  Future<void> quitterApplication() async {
    await windowManager.close();
  }

  // direction path pour enregistrer fichier.txt
  // DEBUT ENREGISTRERMENT FICHIER
  Future<bool> siRepertoireExists(String path) async {
    Directory directory = Directory(path);
    return await directory.exists();
  }

  Future ecrireDonneesSiNecessaire(String nameLogin) async {
    // on appel le repertoire documents
    final directory = await getApplicationDocumentsDirectory();
    final enregistrementDossierLogin = '${directory.path}/login';
    //on verifie dossier login exist
    bool repertoireExist = await siRepertoireExists(enregistrementDossierLogin);

    if (repertoireExist == false) {
      Directory(enregistrementDossierLogin).createSync(recursive: true);
    }

    final file = File('$enregistrementDossierLogin/fichier.txt');
    bool fichierEstVrai = await file.exists();

    final String date = DateTime.now().toString();

    if (fichierEstVrai) {
      //on ajoute le nom et date dans le fichier existant
      IOSink data = file.openWrite(mode: FileMode.append);
      data.write('$nameLogin $date\n');
      await data.flush();
      await data.close();

      // sinon
    } else {
      // on creer un fichier
      await file.writeAsString('$nameLogin $date\n');
    }

    print('Dossier creer');
  }
  //FIN DIRECTION PATH

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 600,
      width: 500,
      child: Form(
          key: cleFormulaire,
          child: Column(
            children: [
              //titre
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blueAccent),
                ),
              ),
              //premier champ saisi => LOGIN
              TextFormField(
                textCapitalization: TextCapitalization.words,
                validator: (String? value) {
                  return (value!.isEmpty)
                      ? 'Merci de renseigner le nom d\'un responsable'
                      : null;
                },
                onSaved: (String? value) => controllerLogin.text = value!,
                decoration: const InputDecoration(
                  labelText: 'Nom du responsable',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              //deuxieme champ saisi => PASSWORD
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Mot de passe',
              //     icon: Icon(Icons.key),
              //   ),
              // ),

              Container(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    //button connexion OR quitter
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 30)),
                        ),
                        onPressed: validationFormulaire,
                        child: const Text('Connexion'),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        //style button
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade900),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 30)),
                        ),
                        onPressed: quitterApplication,
                        child: const Text('Quitter'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: const Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                        image:
                            AssetImage('assets/images/imagesoustitrelogo.png'),
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
