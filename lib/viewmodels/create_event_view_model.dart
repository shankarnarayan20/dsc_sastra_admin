import 'package:dsc_sastra_admin/models/event_model.dart';
import 'package:dsc_sastra_admin/services/dialog_service.dart';
import 'package:dsc_sastra_admin/services/firestore_service.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:dsc_sastra_admin/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class CreateEventViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();
  Future createanEvent({
    @required String title,
    @required String desc,
    @required String venue,
    @required String tag,
    @required String link,
    @required String img,
    @required DateTime datetime,
    @required String speakers,
  }) async {
    setBusy(true);
    Event e = Event(
        dateTime: datetime,
        title: title,
        desc: desc,
        img: img,
        link: link,
        speakers: speakers,
        tag: tag,
        venue: venue);
    var result = await _firestoreService.addEvent(e);
    setBusy(false);

    if (result is String) {
      _dialogService.showDialog(
        title: "Unsuccessful",
        description: result,
      );
    } else {
      _dialogService.showDialog(
        title: 'Successful',
        description: result,
      );
      _navigationService.pop();
    }
  }
}
