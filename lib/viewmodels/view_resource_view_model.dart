import '../locator.dart';
import '../models/resource_model.dart';
import '../services/firestore_service.dart';
import 'base_model.dart';

class ViewResourceViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  getResources() async{
    return _firestoreService.getResource();
  }
  deleteResource(Resource resource) async{
     await _firestoreService.removeEvent(resource.docID);
  }
}
