import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/features/authentication/models/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class StoreDataController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> storeData(String city, String state, String type, String college,
      int pincode, Timestamp timestamp, int currentQuestion) async {
    if (user != null) {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentReference newCollectionRef =
          userCollection.doc(user?.uid).collection('details').doc(college);

      

      Details storeData = Details(
          city: city,
          type: type,
          state: state,
          college: college,
          pincode: pincode,
          timestamp: timestamp,
          currentQuestion: currentQuestion);

      Map<String, dynamic> newData = storeData.toJson();
      

      await newCollectionRef.set(newData);
      
    }
  }
}
