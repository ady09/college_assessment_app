import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class SubcollectionController extends GetxController {
  final RxList<Map<String, dynamic>> subcollectionData =
      <Map<String, dynamic>>[].obs;

  

  Future<void> fetchSubcollectionData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      // Specify the subcollection name you want to fetch data from
      String subcollectionName = 'details';

      QuerySnapshot subcollectionSnapshot = await userCollection
          .doc(user.uid)
          .collection(subcollectionName)
          .orderBy('timestamp', descending: true)
          .get();

      if (subcollectionSnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> data = subcollectionSnapshot.docs
            .map((documentSnapshot) => Map<String, dynamic>.from(
                documentSnapshot.data() as Map<String, dynamic>? ?? {}))
            .toList();

        subcollectionData.value = data;
      } else {
        Get.snackbar("Error", "Not Able To Fetch The Data!");
      }
    }
  }

}
