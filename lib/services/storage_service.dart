import 'dart:io';

import 'package:dsc_sastra_admin/locator.dart';
import 'package:dsc_sastra_admin/services/dialog_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  DialogService _dialogService = locator<DialogService>();
  var downloadUrl;
  uploadSingleImageToStorage(String storagePath, File filePath) async {
    try {
      StorageReference reference = FirebaseStorage.instance.ref().child(storagePath);
      StorageUploadTask uploadTask = reference.putFile(filePath);
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
          return downloadUrl;
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
}
