import '../locator.dart';
import '../models/event_model.dart';
import '../services/firestore_service.dart';
import 'base_model.dart';

class ViewEventViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  getEvent() {
    return _firestoreService.getEvent();
  }

  deleteEvent(Event event) async{
     await _firestoreService.removeEvent(event.docid);
  }
}
