import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  File result;
  var downloadUrl;

  Future createaResource({
    @required String title,
    @required String url,
    @required String desc,
    @required String category,
  }) async {
    Resource r = Resource(
        title: title,
        url: url,
        imageurl: downloadUrl,
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

  addResourceImage(String resourceName) async {
    if (resourceName.isEmpty) {
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
        addResourceImage(resourceName);
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

  uploadImage(String resourceName) async {
    if (resourceName.isEmpty) {
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
          .child('Resources')
          .child('$resourceName' +
              Timestamp.now().millisecondsSinceEpoch.toString());
      StorageUploadTask uploadTask = reference.putFile(result);
      StorageTaskSnapshot storageTaskSnapshot;
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      if (snapshot.error == null) {
        storageTaskSnapshot = snapshot;
        downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      }
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
