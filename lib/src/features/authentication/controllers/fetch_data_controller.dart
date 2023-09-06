import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SubcollectionController extends GetxController {
  final RxList<Map<String, dynamic>> subcollectionData =
      <Map<String, dynamic>>[].obs;

  

  @override
  void onInit() {
    super.onInit();
    fetchSubcollectionData();
  }
  String userName = "";
  Future<void> fetchSubcollectionData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

  
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

  Future<String> fetchDataFromFirestore() async {
    try {
      DocumentReference docRef = firestore.collection('users').doc(userIdConst);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        var currentQuestionValue = docSnapshot
            .get('name'); 

        return currentQuestionValue;
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error: $e');
    }
    return "";
  }
}
