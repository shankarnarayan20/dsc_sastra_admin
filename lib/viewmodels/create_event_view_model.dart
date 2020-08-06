import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import '../models/event_model.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class CreateEventViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  DialogService _dialogService = locator<DialogService>();
  File result;
  var downloadUrl;

  Timestamp _timestamp;
  Timestamp get timestamp => _timestamp;

  Future createanEvent({
    @required String title,
    @required String desc,
    @required String venue,
    @required String tag,
    @required String link,
    @required Timestamp datetime,
    @required String speakers,
    @required String date,
  }) async {
    Event e = Event(
        date: date,
        dateTime: datetime,
        title: title,
        desc: desc,
        img: downloadUrl,
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

  addPoster(String eventName) async {
    if (eventName.isEmpty) {
      _dialogService.showDialog(
        buttonTitle: 'OK',
        description: 'Please enter an event name',
        title: 'Missing Event Name',
      );
      return;
    }
    try {
      if (!await Permission.storage.isGranted) {
        Permission.storage.request();
        addPoster(eventName);
      } else {
        var status = await Permission.storage.status;
        if (status.isGranted) {
          result = await ImagePicker.pickImage(source: ImageSource.gallery);
          notifyListeners();
        } else {
          await _dialogService.showDialog(
            buttonTitle: 'OK',
            title: 'Permission Denied',
            description: 'Please grant storage permission',
          );
        }
      }
    } catch (e) {
      if (e is Exception) print(e);
    }
    print(downloadUrl);
  }

  uploadImage(eventName) async {
    if (eventName.isEmpty) {
      _dialogService.showDialog(
        buttonTitle: 'OK',
        description: 'Please enter member\'s name',
        title: 'Missing Member\'s Name',
      );
      return;
    }
    try {
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child('Events')
          .child(
              '$eventName' + Timestamp.now().millisecondsSinceEpoch.toString());
      StorageUploadTask uploadTask = reference.putFile(result);
      StorageTaskSnapshot storageTaskSnapshot;
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      if (snapshot.error == null) {
        storageTaskSnapshot = snapshot;
        downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          _dialogService.showDialog(
            buttonTitle: 'OK',
            description: 'Imade added successfully',
            title: 'Successful',
          );
        } else {
          _dialogService.showDialog(
            buttonTitle: 'OK',
            description: 'Unsuccessful',
            title: 'Try uploading again',
          );
        }
      }
    } catch (e) {
      _dialogService.showDialog(
        buttonTitle: 'OK',
        description: e,
        title: 'Error!!',
      );
    }
  }

  void clearSelection() {
    result = null;
    notifyListeners();
  }
}
