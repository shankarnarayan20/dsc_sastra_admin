import 'package:dsc_sastra_admin/constants/route_names.dart';
import 'package:dsc_sastra_admin/services/authentication_service.dart';
import 'package:dsc_sastra_admin/services/dialog_service.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  navigateToCreateEvent() {
    _navigationService.navigateTo(CreateEventRoute);
  }

  navigateToViewEvent() {
    _navigationService.navigateTo(ViewEventRoute);
  }

  navigateToCreateResource() {
    _navigationService.navigateTo(CreateResourceRoute);
  }

  navigateToViewResource() {
    _navigationService.navigateTo(ViewResourceRoute);
  }

  navigateToAddImage() {
    _navigationService.navigateTo(AddImageRoute);
  }

  navigateToAddMembers() {
    _navigationService.navigateTo(AddMembersRoute);
  }

  logOutUser() async {
    var response = await _dialogService.showConfirmationDialog(
        title: 'Log Out?',
        cancelTitle: 'No',
        confirmationTitle: 'Yes',
        description: 'Log out from the admin app?');
    if (response.confirmed) {
      _authenticationService.logOutUser();
      bool isUserLoggedIn = await _authenticationService.getCurrentUser();
      if (isUserLoggedIn == false) {
        _dialogService.showDialog(
            title: 'Log Out Successful', description: '', buttonTitle: 'OK');
        _navigationService.navigateToAndRemoveUntil(GoogleSignInViewRoute);
      } else {
        _dialogService.showDialog(
            title: 'Log Out Unsuccessful',
            description: 'Please try again later',
            buttonTitle: 'Try Again');
      }
    }
  }
}
