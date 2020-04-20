import 'package:dsc_sastra_admin/ui/views/create_event_view.dart';
import 'package:dsc_sastra_admin/ui/views/home_view.dart';
import 'package:dsc_sastra_admin/ui/views/view_event_view.dart';
import 'package:flutter/material.dart';
import 'package:dsc_sastra_admin/constants/route_names.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
     case CreateEventRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateEventView(),
      ); 
     case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case ViewEventRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ViewEventView(),
      );  
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
