import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';


class StorageService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadImage({required String filePath, required String fileName}) async {
    String message;
    
    File file = File(filePath);

    try {
      await storage.ref('images/$fileName').putFile(file);

      message = 'Successful';
    } on FirebaseException catch (e) {
      print(e);
      message = '${e.code}';
    }

    return message;
  }

  static Future<String> getDownloadUrl({required String imageName}) async {
    String downloadUrl;
    
    downloadUrl =  await storage.ref('images/$imageName').getDownloadURL();

    return downloadUrl;
  }
}