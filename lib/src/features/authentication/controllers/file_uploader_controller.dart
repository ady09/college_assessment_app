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
        // Get the current location data
        Position position = await getCurrentLocation();

        String userId =
            'user123'; // Replace with your user ID or any unique identifier
        String fileExtension = selectedFile.value!.path.split('.').last;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user_files/$userId/${DateTime.now()}.$fileExtension');

        UploadTask uploadTask = storageReference.putFile(
          File(selectedFile.value!.path),
        );

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
        });

        // Use the downloadURL and geotag information as needed
        print('Download URL: $downloadURL');
        print(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

   Future <Position> getCurrentLocation() async {
    try {
      await _requestLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );
      return position;
    } catch (e) {
      print('Error getting location: $e');
      // Provide a fallback location or handle errors gracefully
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
      // Initialize the Firestore reference
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add geotag information to Firestore
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

      print('Geotag information stored in Firestore');
    } catch (e) {
      print('Error storing geotag information: $e');
    }
  }
}



// class FileUploadController extends GetxController {
//   Rx<PickedFile?> selectedFile = Rx<PickedFile?>(null);
//   String downloadURL = '';
  
//   String? uid;


//   void fetchUid() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String uid = user.uid;
//       print('User UID: $uid');
//     } else {
//       print('No user is currently signed in.');
//     }
//   }

//   Future<void> pickFile(ImageSource source) async {
//     XFile? xFile;
//     if (source == ImageSource.camera) {
//       xFile = await ImagePicker().pickImage(source: source);
//     } else {
//       xFile = await ImagePicker().pickVideo(source: source);
//     }

//     if (xFile != null) {
//       selectedFile.value = PickedFile(xFile.path);
//     }
//   }

//   Future<void> uploadFile() async {
//     if (selectedFile.value != null) {
//       String userId =
//           uid ?? ""; 
//       String fileExtension = selectedFile.value!.path.split('.').last;
//       Reference storageReference = FirebaseStorage.instance.ref().child(
//           'user_files/$userId/${DateTime.now()}.$fileExtension'); 

//       UploadTask uploadTask =
//           storageReference.putFile(File(selectedFile.value!.path));

//       await uploadTask.whenComplete(() async {
//         print('File uploaded successfully');
//         downloadURL = await storageReference.getDownloadURL();
//       });

//       print('Download URL: $downloadURL');
//     } else {
//       print('No file selected');
//     }
//   }
// }
