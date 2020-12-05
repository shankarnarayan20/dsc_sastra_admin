import 'package:shared_preferences/shared_preferences.dart';

import '../constants/route_names.dart';
import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.getCurrentUser();

    if (hasLoggedInUser) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool k = sharedPreferences.getBool('singedIn') == null;
      if (k)
        _navigationService.navigateToAndRemoveUntil(HomeViewRoute);
      else
        _navigationService.navigateTo(PasswordViewRoute);
    } else {
      _navigationService.navigateTo(GoogleSignInViewRoute);
    }
  }
}
