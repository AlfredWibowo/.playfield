import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';


class StorageService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadImage({required String filePath, required String fileName, required isProfilePicture}) async {
    String message;
    
    File file = File(filePath);

    try {
      if (isProfilePicture) {
        await storage.ref('profile_picture/$fileName').putFile(file);
      }
      else {
        await storage.ref('field_picture/$fileName').putFile(file);
      }
      message = 'Successful';
    } on FirebaseException catch (e) {
      print(e);
      message = '${e.code}';
    }

    return message;
  }

  static Future<String> getDownloadUrl({required String imageName, required bool isProfilePicture}) async {
    String downloadUrl;
    
    if (isProfilePicture) {
      downloadUrl =  await storage.ref('profile_picture/$imageName').getDownloadURL();
    }
    else {
      downloadUrl =  await storage.ref('field_picture/$imageName').getDownloadURL();
    }

    return downloadUrl;
  }
}