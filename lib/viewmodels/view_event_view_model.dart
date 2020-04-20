import 'package:dsc_sastra_admin/services/firestore_service.dart';
import 'package:dsc_sastra_admin/viewmodels/base_model.dart';

import '../locator.dart';

class ViewEventViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  getEvent() {
    return _firestoreService.getEvent();
  }
}
