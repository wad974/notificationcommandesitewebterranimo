import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notification_app_woocommerce/view/footer.dart';
import 'package:notification_app_woocommerce/view/header.dart';
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
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: reduireFenetre,
                            icon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          height: 1300,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // footer
          const Footer(),
        ],
      ),
    );
  }
}
