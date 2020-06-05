import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import '../models/member_model.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class AddMembersViewModel extends BaseModel {
  DialogService _dialogService = locator<DialogService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  String downloadUrl;
  File result;

  addMember({
    @required String name,
    @required String instagram,
    @required String linkedIn,
    @required String twitter,
    @required String cluster,
    @required String clusterPath,
  }) async {
    Member m = Member(
        socialMedia: SocialMedia(
          instagram: instagram,
          linkedin: linkedIn,
          twitter: twitter,
        ),
        cluster: cluster,
        name: name,
        imageurl: downloadUrl);
    var result = await _firestoreService.addMember(m, clusterPath);

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

  addImage(String name) async {
    if (name.isEmpty) {
      _dialogService.showDialog(
        buttonTitle: 'OK',
        description: 'Please enter member\'s name',
        title: 'Missing Member\'s Name',
      );
      return;
    }
    try {
      if (!await Permission.storage.isGranted) {
        Permission.storage.request();
        addImage(name);
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

  uploadImage(name) async {
    if (name.isEmpty) {
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
          .child('Members')
          .child('$name' + Timestamp.now().millisecondsSinceEpoch.toString());
      StorageUploadTask uploadTask = reference.putFile(result);
      StorageTaskSnapshot storageTaskSnapshot;
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      if (snapshot.error == null) {
        storageTaskSnapshot = snapshot;
        downloadUrl = (await storageTaskSnapshot.ref.getDownloadURL());
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
