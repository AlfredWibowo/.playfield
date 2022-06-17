import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';


class StorageService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> uploadUserProfileImage({required String filePath, required String fileName}) async {
    File file = File(filePath);

    try {
      await storage.ref('images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // static Future<void> uploadUserProfileImageWeb({required Uint8List fileBytes, required String fileName}) async {
  //   try {
  //     await storage.ref('user/profile_images/$fileName').putFile(fileBytes);
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   }
  // }

  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl = await storage.ref('images/$imageName').getDownloadURL();

    return downloadUrl;
  }
}