import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_sastra_admin/services/storage_service.dart';
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
  StorageService _storageService = locator<StorageService>();
  String downloadUrl;
  File result;
  //DateTime year;

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

  // selectYear() {
  //   CalendarDatePicker(
  //     initialDate: DateTime(DateTime.now().year),
  //     firstDate: DateTime(2017),
  //     lastDate: DateTime(2030),
  //     onDateChanged: (selectedYear) {
  //       year = selectedYear;
  //       notifyListeners();
  //     },
  //     initialCalendarMode: DatePickerMode.year,
  //   );
  // }

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
    String _path;
    _path = 'Members/$name' + Timestamp.now().millisecondsSinceEpoch.toString();
    downloadUrl = _storageService.uploadSingleImageToStorage(_path, result);
  }

  void clearSelection() {
    result = null;
    notifyListeners();
  }
}
