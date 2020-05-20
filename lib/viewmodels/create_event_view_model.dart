import 'package:cloud_firestore/cloud_firestore.dart';
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

  Timestamp _timestamp;
  Timestamp get timestamp => _timestamp;

  Future createanEvent({
    @required String title,
    @required String desc,
    @required String venue,
    @required String tag,
    @required String link,
    @required String img,
    @required Timestamp datetime,
    @required String speakers,
  }) async {
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

  pickdate(context) async {
    DateTime temp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
    );
    TimeOfDay k = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    _timestamp = Timestamp.fromDate(
      DateTime(
        DateTime.now().year,
        temp.month,
        temp.day,
        k.hour,
        k.minute,
        0,
        0,
        0,
      ),
    );
    notifyListeners();
  }
}
