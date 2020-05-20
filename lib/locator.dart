import 'package:dsc_sastra_admin/services/authentication_service.dart';
import 'package:dsc_sastra_admin/services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:dsc_sastra_admin/services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => AuthenticationService());
}
