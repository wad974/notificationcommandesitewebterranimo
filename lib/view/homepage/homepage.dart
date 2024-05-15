import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
          Container(
            height: 30,
            color: const Color.fromRGBO(192, 69, 61, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                const SizedBox(width: 15),
                Text(
                  'Bonjour $loginName',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white70),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
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

          Container(
            height: 20,
            color: HexColor("#2B353E"),
          )
        ],
      ),
    );
  }
}
