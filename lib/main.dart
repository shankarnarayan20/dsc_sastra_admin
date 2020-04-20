import 'package:dsc_sastra_admin/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:dsc_sastra_admin/services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  setupLocator(); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSC Admin',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      home: HomeView(),
      onGenerateRoute: generateRoute,
    );
  }
}
