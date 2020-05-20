import 'package:shared_preferences/shared_preferences.dart';

import '../constants/route_names.dart';
import '../locator.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class PasswordViewModel extends BaseModel {
  checkPassword(String password) async {
    DialogService _dialogService = locator<DialogService>();
    FirestoreService _firestoreService = locator<FirestoreService>();
    NavigationService _navigationService = locator<NavigationService>();
    String _password = await _firestoreService.getPasswordOnceOff();
    if (password == _password) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setBool('signedIn', true);
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _dialogService.showDialog(
        title: 'Invalid password',
        description: 'Please try again',
      );
    }
  }
}
