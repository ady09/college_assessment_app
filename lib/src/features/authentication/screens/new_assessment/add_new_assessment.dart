import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/common_widgets/buttons/submit_button.dart';
import 'package:college_assessment_app/src/common_widgets/form/input_field.dart';
import 'package:college_assessment_app/src/constants/image_strings.dart';
import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/fetch_data_controller.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/store_data_controller.dart';
import 'package:college_assessment_app/src/features/authentication/screens/home_screen/home_screen.dart';

import 'package:college_assessment_app/src/utils/theme/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddNewAssessment extends StatelessWidget {
  final SubcollectionController subcollectionController =
      Get.put(SubcollectionController());
  AddNewAssessment({super.key});

  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeScreen screen = HomeScreen();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 50, width: 50, child: Image(image: AssetImage(logo)))
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 22),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Assessment",
                  style: CustomTextTheme.AppBarStyle,
                ),
                SizedBox(height: height * 0.024),
                InputField(
                  title: "College Name",
                  hint: "Please Enter College Name ",
                  controller: _collegeController,
                  keyboardType: TextInputType.text,
                ),
                InputField(
                  title: "State",
                  hint: "Please Enter State here",
                  controller: _stateController,
                  keyboardType: TextInputType.text,
                ),
                InputField(
                  title: "City",
                  hint: "Please Enter City here ",
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                ),
                InputField(
                  title: "Pincode",
                  hint: "Please Enter Pincode ",
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                ),
                InputField(
                  title: "Type",
                  hint: "Please Enter Type such as Eng, Medical, etc ",
                  controller: _typeController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: height * 0.054),
                Center(
                    child: SubmitButton(
                        label: "Submit",
                        onTap: () async {
                          if (await _validateData()) {
                            await screen.fetchDataList();
                          } else {
                            Get.snackbar("Error",
                                "Please check if the college details already exists!",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _validateData() async {
    if (_collegeController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _pincodeController.text.isNotEmpty &&
        _typeController.text.isNotEmpty) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference userDocRef =
            firestore.collection('users').doc(userIdConst);
        CollectionReference subcollectionRef = userDocRef.collection('details');
        DocumentReference docRef =
            subcollectionRef.doc(_collegeController.text);

        DocumentSnapshot docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          return false;
        } else {
          StoreDataController storeDataController = StoreDataController();

          try {
            String pincodeText =
                _pincodeController.text.replaceAll(' ', '').trim();

            if (pincodeText.isNotEmpty &&
                pincodeText.contains(RegExp(r'^[0-9]+$'))) {
              int pincode = int.parse(pincodeText);
              storeDataController.storeData(
                  _cityController.text.trim(),
                  _stateController.text.trim(),
                  _typeController.text.trim(),
                  _collegeController.text.trim(),
                  pincode,
                  Timestamp.now(),
                  0);
            } else {
              Get.snackbar("Pincode Error",
                  "Please Enter a valid Pincode with only digits.");
            }
          } catch (e) {
            Get.snackbar("Error", "An unexpected error occurred: $e");
          }

          await subcollectionController.fetchSubcollectionData();
        }
      } catch (e) {
        e.toString();
      }

      Get.back();
    } else if (_collegeController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _pincodeController.text.isEmpty ||
        _typeController.text.isEmpty) {
      Get.snackbar("Error", "All fields are mandatory!",
          snackPosition: SnackPosition.BOTTOM);
    }
    return true;
  }
}
