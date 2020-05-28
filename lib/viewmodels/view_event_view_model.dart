import 'package:dsc_sastra_admin/services/dialog_service.dart';

import '../locator.dart';
import '../models/event_model.dart';
import '../services/firestore_service.dart';
import 'base_model.dart';

class ViewEventViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();
  getEvent() {
    return _firestoreService.getEvent();
  }

  deleteEvent(Event event) async {
    var response = await _dialogService.showConfirmationDialog(
      title: 'Delete',
      description: 'Are you sure?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Yes',
    );
    if (response.confirmed) {
      await _firestoreService.removeEvent(event.docid);
    }

    
  }
}
