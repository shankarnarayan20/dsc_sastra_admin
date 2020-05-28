import 'package:dsc_sastra_admin/ui/views/add_images.dart';
import 'package:flutter/material.dart';

import '../constants/route_names.dart';
import 'views/add_members.dart';
import 'views/create_event_view.dart';
import 'views/create_resource_view.dart';
import 'views/google_signin_view.dart';
import 'views/home_view.dart';
import 'views/password_view.dart';
import 'views/view_event_view.dart';
import 'views/view_resource_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case GoogleSignInViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: GoogleSignInView(),
      );
    case PasswordViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PasswordView(),
      );
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
    case CreateResourceRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateResourceView(),
      );
    case ViewResourceRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ViewResourceView(),
      );
    case AddMembersRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddMembersView(),
      );
    case AddImageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddImagesView(),
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
