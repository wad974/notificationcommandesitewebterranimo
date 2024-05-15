// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notification_app_woocommerce/view/log/login_page.dart';

class DrawerPage extends StatelessWidget {
  //final Function()? refresh;

  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        child: Column(
          children: [
            //titre image Terranimo
            DrawerHeader(
              child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    Ink(
                      child: const Image(
                        image: AssetImage(
                            'assets/images/terranimo-removebg-preview.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Orders'),
                    hoverColor: Colors.grey.shade300,
                    iconColor: Colors.red.shade800,
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Account'),
                    hoverColor: Colors.grey.shade300,
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('Rafraichir'),
                    hoverColor: Colors.grey.shade300,
                    iconColor: Colors.red.shade500,
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              hoverColor: Colors.grey.shade300,
              iconColor: Colors.black,
              onTap: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
