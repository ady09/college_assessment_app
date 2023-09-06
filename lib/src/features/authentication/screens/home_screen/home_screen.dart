import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/common_widgets/buttons/add_button.dart';
import 'package:college_assessment_app/src/common_widgets/list_animation/present_list.dart';
import 'package:college_assessment_app/src/constants/text_strings.dart';

import 'package:college_assessment_app/src/features/authentication/models/details.dart';

import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/assessment_screen.dart';
import 'package:college_assessment_app/src/features/authentication/screens/new_assessment/add_new_assessment.dart';
import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

import '../../controllers/fetch_data_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({this.details});

  final Details? details;

  final SubcollectionController _subcollectionController =
      Get.put(SubcollectionController());
  // final AssessmentController _controller = Get.put(AssessmentController());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final firebaseAuth.User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 18,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customHeader(),
                MyButton(
                    label: "New Assessment",
                    onTap: () => (Get.to(AddNewAssessment()))),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.044,
          ),
          fetchDataList(),
        ],
      ),
    );
  }

  _customHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.yMMMd().format(DateTime.now()),
              style: CustomTextTheme.subHeadingStyle),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text("Hello!", style: CustomTextTheme.HeadingStyle),
          ),
        ],
      ),
    );
  }

  fetchDataList() {
    return Obx(() {
      if (_subcollectionController.subcollectionData.isEmpty) {
        return const Text('No data available.');
      } else {
        String? uid = user?.uid;
        _firestore
            .collection('users')
            .doc(uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {}
        });
        return _listData();
      }
    });
  }

  _listData() {
    return Expanded(
      child: ListView.builder(
        itemCount: _subcollectionController.subcollectionData.length,
        itemBuilder: (context, index) {
          final Details detail = Details.fromJson(
              _subcollectionController.subcollectionData[index]);
          // Map<String, dynamic> item =
          //     _subcollectionController.subcollectionData[index];
          return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                    child: Row(
                  children: [
                    Obx(() {
                      return IgnorePointer(
                        ignoring: false,
                        child: GestureDetector(
                          onTap: () async {
                            int currentQuestionValue = 0;
                            try {
                              DocumentReference docRef = firestore
                                  .collection('users')
                                  .doc(userIdConst)
                                  .collection('details')
                                  .doc(detail.college);
                              DocumentSnapshot docSnapshot = await docRef.get();

                              if (docSnapshot.exists) {
                                currentQuestionValue = docSnapshot.get(
                                    'current question'); // Replace 'field_name' with the actual field name
                                print('Value: $currentQuestionValue');
                              } else {
                                print(details?.college);
                                print('Document does not exist');
                              }
                            } catch (e) {
                              print('Error: $e');
                            }

                            int currentQuestionFirebase =
                                detail.currentQuestion;
                            String collegeFirebase = detail.college;
                            print(
                                "Item id is $currentQuestionFirebase and $collegeFirebase");
                            await Get.to(AssessmentScreen(
                              collegeFirebase: collegeFirebase,
                              currentQuestionIndexFirebase:
                                  currentQuestionValue,
                            ));
                          },
                          child: TaskTile(
                            Details.fromJson(_subcollectionController
                                .subcollectionData[index]),
                            widget: taskStatus(detail.college),
                          ),
                        ),
                      );
                    })
                  ],
                )),
              ));
        },
      ),
    );
  }

  Widget taskStatus(String collegeDocId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userIdConst)
          .collection('details')
          .doc(collegeDocId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(); // Loading indicator
        }

        final progressData = snapshot.data?.data() as Map<String, dynamic>;
        final isCompleted = progressData['isCompleted'] ?? false;

        return Text(isCompleted ? 'Completed' : 'In Progress',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ));
      },
    );
  }
}
