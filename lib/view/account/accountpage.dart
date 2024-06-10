// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:notification_app_woocommerce/Controller/http.dart';
import 'package:notification_app_woocommerce/model/config_param.dart';
import 'package:notification_app_woocommerce/view/account/sousdossier/form_api_woocommerce.dart';

import '../../Controller/params.dart';
import '../../widget/drawer/drawerpage.dart';
import '../footer.dart';
import '../header.dart';
import 'sousdossier/form_api_python.dart';

class AccountPage extends StatefulWidget {
  static String routeName = 'account';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //GlobalKey pour formulaire parametre
  final _formKey = GlobalKey<FormState>();
  final _formApiKey = GlobalKey<FormState>();
  //textediting
  final TextEditingController input = TextEditingController();
  final TextEditingController inputApiPython = TextEditingController();
  //init sql
  final ParamsDatabase _dbParams = ParamsDatabase();
  //List Params
  List configList = [];
  String urlApiPython = '';
  String urlApiWooCommerce = '';
  //init requetteHTTP
  final RequeteHttp req = RequeteHttp();

  @override
  void initState() {
    super.initState();
    //init sql
    _dbParams.openSqlParams().then((context) => afficheParams());
  }

  //dispose pour netoyer le input
  @override
  void dispose() {
    super.dispose();
    inputApiPython.dispose();
    input.dispose();
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

  // insertdataapiWoocommerce
  Future<void> insertDataApi(String url) async {
    int id = 0;
    var url_api = Params(id: id, url: url);
    await _dbParams.insertParams(url_api);
    await req.postUrlApi(url.toString());
  }

  //valideFormApiPython
  void valideFormApiPython() {
    if (_formApiKey.currentState!.validate()) {
      setState(() {
        insertDataApiPython(inputApiPython.text);
        const duration = Duration(seconds: 1);
        Timer.periodic(duration, (timer) {
          afficheParams();
          timer.cancel();
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(inputApiPython.text)),
        ),
      );
    }
  }

  // insertdataapiPython
  Future<void> insertDataApiPython(String url) async {
    int id = 1;
    var url_api = Params(id: id, url: url);
    await _dbParams.insertParams(url_api);
  }

  // affiche les params
  Future<void> afficheParams() async {
    List<Params> listParams = await _dbParams.listesParamsArchivers();
    setState(() {
      configList = listParams;
      urlApiWooCommerce = configList[0].url;
      urlApiPython = configList[1].url;
      print('ici $configList');
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
                              children: [
                                // champ Form pour parametres
                                //api woocommerce
                                Container(
                                  child: FormApiWooCommerce(
                                    urlApiWooCommerce: urlApiWooCommerce,
                                    formKey: _formKey,
                                    input: input,
                                    valideForm: valideForm,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Expanded(
                                  child: Container(
                                    child: FormApiPython(
                                      urlApiPython: urlApiPython,
                                      formApiKey: _formApiKey,
                                      input: inputApiPython,
                                      valideFormApiPython: valideFormApiPython,
                                    ),
                                  ),
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
