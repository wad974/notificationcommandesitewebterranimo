// ignore_for_file: deprecated_member_use, unused_local_variable

//
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notification_app_woocommerce/view/homepage/homepage.dart';
//import 'view/homepage/homepage.dart';
//window
import 'package:window_manager/window_manager.dart';

import 'view/login/login_page.dart';

//void main
void main() async {
  //init the hive
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');

  WidgetsFlutterBinding.ensureInitialized();
  // Fenetere Dimension.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      // size: Size(1600, 1000),
      minimumSize: Size(1366 , 768),
      fullScreen: false,
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: true,
      title: 'Notification Terranimo.re');
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // demarre
  runApp(const NotificationWooCommerce());
}

class NotificationWooCommerce extends StatelessWidget {
  const NotificationWooCommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // on enleve le debug
      debugShowCheckedModeBanner: false,
      // titre
      title: 'Notification Terranimo.re',
      // on defini la route principal
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
