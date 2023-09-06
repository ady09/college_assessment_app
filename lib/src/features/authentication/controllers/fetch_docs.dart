import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class FetchDocsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString parentDocumentId = ''.obs;
  RxString subCollectionDocumentId = ''.obs;

  Future<void> fetchParentDocument() async {
   

    final DocumentReference parentDocumentRef =
        firestore.collection('users').doc(parentDocumentId.value);

    try {
      final DocumentSnapshot parentDocumentSnapshot =
          await parentDocumentRef.get();

      if (parentDocumentSnapshot.exists) {
       
        parentDocumentId.value = parentDocumentSnapshot.id;
      } else {
        parentDocumentId.value = ''; 
      }
    } catch (error) {
      print('Error fetching parent document: $error');
    }
  }

  Future<void> fetchSubCollectionDocument() async {
    final DocumentReference subCollectionDocumentRef = firestore
        .collection('users/$parentDocumentId/details')
        .doc(subCollectionDocumentId.value);

    try {
      final DocumentSnapshot subCollectionDocumentSnapshot =
          await subCollectionDocumentRef.get();

      if (subCollectionDocumentSnapshot.exists) {
        
        subCollectionDocumentId.value = subCollectionDocumentSnapshot.id;
      } else {
        subCollectionDocumentId.value =
            ''; 
      }
    } catch (error) {
      print('Error fetching subcollection document: $error');
    }
  }

  
}
