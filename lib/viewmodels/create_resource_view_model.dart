import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/resource_model.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class CreateResourceViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();

  Future createaResource({
    @required String title,
    @required String url,
    @required String imageurl,
    @required String desc,
    @required String category,
  }) async {
    Resource r = Resource(
        title: title,
        url: url,
        imageurl: imageurl,
        description: desc,
        category: category);
    var result = await _firestoreService.addResource(r);
    
    if (result is String) {
      _dialogService.showDialog(
        title: "Unsuccessful",
        description: result ?? '',
      );
    } else {
      _dialogService.showDialog(
        title: 'Successful',
        description: result ?? '',
      );
      _navigationService.pop();
    }
  }
}
