import 'package:dsc_sastra_admin/constants/route_names.dart';
import 'package:dsc_sastra_admin/services/authentication_service.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:dsc_sastra_admin/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

class GoogleSignInViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  signInWithGoogle() {
    _authenticationService.signInWithGoogle().whenComplete(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getBool('signedIn') == null) {
        _navigationService.navigateTo(PasswordViewRoute);
      } else {
        _navigationService.navigateTo(HomeViewRoute);
      }
    });
  }
}
