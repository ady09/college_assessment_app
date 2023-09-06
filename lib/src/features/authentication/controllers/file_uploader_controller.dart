import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class Geotag {
  final String url;
  final double latitude;
  final double longitude;

  Geotag({
    required this.url,
    required this.latitude,
    required this.longitude,
  });
}

class FileUploadController extends GetxController {
  Rx<PickedFile?> selectedFile = Rx<PickedFile?>(null);
  String downloadURL = '';
  User? user = FirebaseAuth.instance.currentUser;
  var isUploading = false.obs;
  var uploadProgress = 0.0.obs;

  Future<void> pickFile(ImageSource source) async {
    try {
      XFile? xFile;
      if (source == ImageSource.camera) {
        xFile = await ImagePicker().pickImage(source: source);
      } else {
        xFile = await ImagePicker().pickVideo(source: source);
      }

      if (xFile != null) {
        selectedFile.value = PickedFile(xFile.path);
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Location permission granted, you can now use location services
    } else if (status.isDenied) {
      // Location permission denied by the user
      // You can show a dialog or message explaining why location is needed
      // and guide the user to enable it in device settings.
      Get.snackbar("Location Denied",
          "Please Turn on Location Services to Upload The Image");
    } else if (status.isPermanentlyDenied) {
      // Location permission permanently denied by the user
      // You can show a message directing the user to app settings
      // where they can manually enable location permissions.
      Get.snackbar("Location Denied",
          "Please Turn on Location Services from Settings to Upload The Image");
    }
  }

  Future<void> uploadFileWithGeoTag() async {
    try {
      if (selectedFile.value != null) {
        isUploading(true);
        // Get the current location data
        Position position = await getCurrentLocation();

        String? userId = user?.uid;
        // Replace with your user ID or any unique identifier
        String fileExtension = selectedFile.value!.path.split('.').last;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user_files/$userId/${DateTime.now()}.$fileExtension');

        UploadTask uploadTask = storageReference.putFile(
          File(selectedFile.value!.path),
        );

        uploadTask.snapshotEvents.listen((TaskSnapshot event) {
          final double progress =
              event.bytesTransferred / event.totalBytes;
          uploadProgress.value = progress;
        });


        await uploadTask.whenComplete(() async {
          print('File uploaded successfully');
          downloadURL = await storageReference.getDownloadURL();

          // Create a Geotag object
          Geotag geotag = Geotag(
            url: downloadURL,
            latitude: position.latitude,
            longitude: position.longitude,
          );

          // Store geotag information in Firestore
          await storeGeoTagInfo(geotag);
          isUploading(false);
        });

        // Use the downloadURL and geotag information as needed
        print('Download URL: $downloadURL');
        print(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      } else {
        Get.snackbar("Error", "Please Upload Image/Video");
        print('No file selected');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      await _requestLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 25),
      );
      return position;
    } catch (e) {
      print('Error getting location: $e');
     
      return Position(
          latitude: 0.0,
          longitude: 0.0,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          timestamp: DateTime.now());
    }
  }

  Future<void> storeGeoTagInfo(Geotag geotag) async {
    try {
     
      FirebaseFirestore firestore = FirebaseFirestore.instance;

    
      await firestore
          .collection('users')
          .doc(user?.uid)
          .collection('geotags')
          .add({
        'url': geotag.url,
        'latitude': geotag.latitude,
        'longitude': geotag.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
        "Success",
        "File has been successfully uploaded!",
        icon: Icon(Icons.done),
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Geotag information stored in Firestore');
    } catch (e) {
      print('Error storing geotag information: $e');
    }
  }
}



