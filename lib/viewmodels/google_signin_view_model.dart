import '../constants/route_names.dart';
import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class GoogleSignInViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  bool hasUserSignedIn;
  signInWithGoogle() {
    _authenticationService.signInWithGoogle().whenComplete(() async {
      hasUserSignedIn = await _authenticationService.getCurrentUser();
      if (hasUserSignedIn) {
        _navigationService.navigateTo(PasswordViewRoute);
      }
    });
  }
}
