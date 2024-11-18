import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get image data as Uint8List from assets
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading image data: $e';
    }
  }

  // Get image file from assets
  Future<File> getImageFileFromAssets(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${basename(assetPath)}');
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      return tempFile;
    } catch (e) {
      throw 'Error loading image from assets: $e';
    }
  }

  // Upload Uint8List image data to Firebase Storage and return the download URL
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _storage.ref(path).child(name); // Firebase Storage reference
      await ref.putData(image); // Upload raw image data (Uint8List)
      final url =
          await ref.getDownloadURL(); // Get download URL after uploading
      return url;
    } catch (e) {
      // Handle errors (consider using a custom exception handler)
      throw 'Error uploading image: $e';
    }
  }

  // Upload image file to Firebase Storage and return the download URL
  Future<String> uploadImageFile(String path, File file, String name) async {
    try {
      final ref = _storage.ref(path).child(name);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'Error uploading image file: $e';
    }
  }
}
