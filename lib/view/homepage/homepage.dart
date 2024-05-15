import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/view/footer.dart';
import 'package:notification_app_woocommerce/view/header.dart';
import 'package:notification_app_woocommerce/view/homepage/orders/orderspage.dart';
import 'package:notification_app_woocommerce/view/homepage/orders/sousdossier/list_orders.dart';
// 'package:notification_app_woocommerce/view/log/login_page.dart';
import 'package:notification_app_woocommerce/widget/drawer/drawerpage.dart';
import 'package:window_manager/window_manager.dart';

//import '../../Controller/http.dart'
//import 'package:notification_app_woocommerce/widget/drawer/drawerpage.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';

  const HomePage({super.key});

  // reduire la fenêtre
  Future<void> reduireFenetre() async {
    //print('minimmize');
    await windowManager.minimize();
  }

  @override
  Widget build(BuildContext context) {
    //on recuperer les données de navigator.pushNamed
    final loginName = ModalRoute.of(context)!.settings.arguments as String;

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
                const DrawerPage(),
                // un expanded
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   padding: const EdgeInsets.all(10),
                        //   child: IconButton(
                        //     onPressed: reduireFenetre,
                        //     icon: const Icon(Icons.arrow_drop_down),
                        //   ),
                        // ),
                        // contenu orders
                        Container(
                          // color: Colors.red,
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              // TTITRE ORDERS
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Commandes',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 40),

                              // LISTE ORDERS CONTAINER
                              Container(
                                height: 800,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                child: Column(
                                  children: [
                                    // champ input recherche
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 800,
                                      child: const TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.search),
                                            labelText:
                                                'Search for Order ID, Customer , order Status',
                                            border: OutlineInputBorder()),
                                      ),
                                    ),

                                    // list commandes
                                    const listOrders(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
