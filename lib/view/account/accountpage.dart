import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/Controller/http.dart';
import 'package:notification_app_woocommerce/model/config_param.dart';

import '../../Controller/params.dart';
import '../../widget/drawer/drawerpage.dart';
import '../footer.dart';
import '../header.dart';

class AccountPage extends StatefulWidget {
  static String routeName = 'account';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //GlobalKey pour formulaire parametre
  final _formKey = GlobalKey<FormState>();
  //textediting
  final TextEditingController input = TextEditingController();
  //init sql
  final ParamsDatabase _db = ParamsDatabase();
  //List Params
  List configList = [];
  //init requetteHTTP
  final RequeteHttp req = RequeteHttp();

  @override
  void initState() {
    //init sql
    _db.openSqlParams().then((context) => afficheParams());

    super.initState();
  }

  //dispose pour netoyer le input
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  //valideForm
  void valideForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        insertDataApi(input.text);
        const duration = Duration(seconds: 1);
        Timer.periodic(duration, (timer) {
          afficheParams();
          timer.cancel();
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(input.text)),
        ),
      );
    }
  }

  // insertdataapi
  Future<void> insertDataApi(String url) async {
    int id = 0;
    var url_api = Params(id: id, url: url);
    await _db.insertParams(url_api);
    await req.postUrlApi(url.toString());
  }

  // affiche les params
  Future<void> afficheParams() async {
    List<Params> listParams = await _db.listesParamsArchivers();
    setState(() {
      configList = listParams;
      print(configList);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          'Paramètre',
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
                                // champ Form pour parametres
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // div url api
                                        Container(
                                          height: 75,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // champ api
                                              Container(
                                                width: 700,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                  controller: input,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Url API',
                                                    icon: Icon(Icons.link),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Merci de remplir l'adresse de l'API";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),

                                              // champ bouton
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: 200,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        minimumSize:
                                                            MaterialStateProperty.all(
                                                                Size(200, 60)),
                                                        foregroundColor:
                                                            MaterialStateProperty.all(
                                                                Colors.white),
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                Color.fromRGBO(
                                                                    192, 69, 61, 1)),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(5)))),
                                                    onPressed: () {
                                                      valideForm();
                                                    },
                                                    child: const Text('Enregistre')),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //on affiche les parametre déjà enregistrer
                                        Container(
                                          height: 200,
                                          child: ListView.builder(
                                              itemCount: configList.length,
                                              itemBuilder: (context, index) {
                                                print(configList[index].url);
                                                return Text(
                                                    ' url API : ${configList[index].url}');
                                              }),
                                        ),
                                      ],
                                    ))
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
