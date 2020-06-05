import 'package:dsc_sastra_admin/services/firestore_service.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:dsc_sastra_admin/ui/widgets/cluster_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import '../services/dialog_service.dart';
import 'base_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddImagesViewModel extends BaseModel {
  int _len;
  DialogService _dialogService = locator<DialogService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<Asset> resultList;
  bool error = false;
  int get length => _len;

  Future<void> addImages() async {
    try {
      if (!await Permission.storage.isGranted) {
        Permission.storage.request();
        addImages();
      } else {
        var status = await Permission.storage.status;
        if (status.isGranted) {
          resultList = await MultiImagePicker.pickImages(maxImages: 100);
          getImageCount();
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
  }

  uploadImage(Cluster cluster, String eventName) async {
    if (eventName == null) {
      _dialogService.showDialog(
        buttonTitle: 'OK',
        description: 'Please enter the event name',
        title: 'Error!',
      );
      return null;
    }
    int i = 1;
    resultList.forEach((Asset asset) async {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child('Event Images')
          .child(cluster.name)
          .child(eventName)
          .child(Timestamp.now().millisecondsSinceEpoch.toString());
      StorageUploadTask uploadTask = reference.putData(imageData);
      StorageTaskSnapshot storageTaskSnapshot;

      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      if (snapshot.error == null) {
        storageTaskSnapshot = snapshot;
        final String downloadUrl =
            await storageTaskSnapshot.ref.getDownloadURL();
        //uploadUrls.add(downloadUrl);
        addToFirestore(downloadUrl, cluster, eventName, i);
        i++;
        print('Upload success');
      } else {
        print('Error from image repo ${snapshot.error.toString()}');
        throw ('This file is not an image');
      }
    });
    _dialogService.showDialog(
      buttonTitle: 'OK',
      description: 'The $_len images have been uploaded successfully',
      title: 'Success',
    );
    _navigationService.pop();
  }

  addToFirestore(String downloadUrl, Cluster cluster, String eventName, int i) {
    String path = 'images/${cluster.id}/$eventName/image$i';
    _firestoreService.addImages(downloadUrl, path);
  }

  void clearSelections() {
    resultList = [];
    getImageCount();
  }

  void getImageCount() {
    _len = resultList.length;
    notifyListeners();
  }
}
