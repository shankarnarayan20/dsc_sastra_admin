import 'package:dsc_sastra_admin/constants/route_names.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  navigateToCreateEvent() {
    _navigationService.navigateTo(CreateEventRoute);
  }

  navigateToViewEvent() {
    _navigationService.navigateTo(ViewEventRoute);
  }
}
