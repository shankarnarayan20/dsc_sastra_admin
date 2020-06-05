import 'package:dsc_sastra_admin/services/dialog_service.dart';

import '../locator.dart';
import '../models/resource_model.dart';
import '../services/firestore_service.dart';
import 'base_model.dart';

class ViewResourceViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();
  getResources() {
    return _firestoreService.getResource();
  }

  deleteResource(Resource resource) async {
    var response = await _dialogService.showConfirmationDialog(
      title: 'Delete',
      description: 'Are you sure?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Yes',
    );
    if (response.confirmed) {
      await _firestoreService.removeRessource(resource.docID);
    }
  }
}
