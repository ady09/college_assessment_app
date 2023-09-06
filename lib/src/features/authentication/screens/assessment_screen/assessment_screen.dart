import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/common_widgets/buttons/assessmentButton.dart';
import 'package:college_assessment_app/src/common_widgets/buttons/submit_button.dart';
import 'package:college_assessment_app/src/common_widgets/list_animation/present_list.dart';
import 'package:college_assessment_app/src/constants/text_strings.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:college_assessment_app/src/features/authentication/models/details.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/assessment_container_widget.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/header_container_widget.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/question_data.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/sub_header_container.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/yes_no_question.dart';
import 'package:college_assessment_app/src/features/authentication/screens/home_screen/home_screen.dart';
import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common_widgets/drop_down_list/drop_down_widget.dart';
import '../../controllers/file_uploader_controller.dart';
import '../../models/assessment.dart';
import 'text_answer.dart';

class AssessmentScreen extends StatelessWidget {
  AssessmentScreen(
      {super.key,
      required this.currentQuestionIndexFirebase,
      required this.collegeFirebase});

  // static final AssessmentController _assessmentController =
  final AssessmentController _controller = Get.put(AssessmentController());

  int currentQuestionIndexFirebase;
  final String collegeFirebase;
  final QuestionData data = QuestionData();

  // AssessmentScreen({
  final FileUploadController _fileUploadController =
      Get.put(FileUploadController());

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userIdConst)
        .collection('details')
        .doc(collegeFirebase);
    var height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Text(
            "Active Assessment",
            style: CustomTextTheme.HeadingStyle,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final int currentQuestionIndex =
            _controller.currentQuestionIndex.value + 1;
        return SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.038),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Curriculum",
                    style: CustomTextTheme.medSubTitle,
                  ),
                ),
                SizedBox(height: height * 0.03),
                const HeaderContainerWidget(
                  curriculumText: "SECTION  03 / 05",
                  curriculumTextContent:
                      "Implementation of Curriculum by Institution/College in alignment with Program Specific Competences laid down by MC",
                ),
                SizedBox(height: height * 0.026),
                SubHeaderContainerWidget(
                    questionNo:
                        "QUESTION:  ${currentQuestionIndexFirebase + 1}",
                    question: _controller
                        .getCurrentQuestion(currentQuestionIndexFirebase)
                        .text,
                    widget: _controller
                                .getCurrentQuestion(
                                    currentQuestionIndexFirebase)
                                .type ==
                            QuestionType.dropdown
                        ? DropDownWidget(
                            question: _controller.getCurrentQuestion(
                                currentQuestionIndexFirebase))
                        : _controller
                                    .getCurrentQuestion(
                                        currentQuestionIndexFirebase)
                                    .type ==
                                QuestionType.yesNo
                            ? YesNoQuestion(
                                question: _controller.getCurrentQuestion(
                                    currentQuestionIndexFirebase),
                              )
                            : _controller
                                        .getCurrentQuestion(
                                            currentQuestionIndexFirebase)
                                        .type ==
                                    QuestionType.text
                                ? TextQuestion(
                                    question: _controller.getCurrentQuestion(
                                        currentQuestionIndexFirebase))
                                : TextQuestion(
                                    question: _controller.getCurrentQuestion(
                                        currentQuestionIndexFirebase))),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Upload Evidence",
                    style: CustomTextTheme.questionTitleStyle,
                  ),
                ),
                const SizedBox(height: 20),
                AssessmentContainerWidget(
                  widget: _fileUploadController.selectedFile.value != null
                      ? Image.file(
                          File(_fileUploadController.selectedFile.value!.path))
                      : Center(child: const Text('No file selected')),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AssessmentButton(
                        label: "Camera",
                        onTap: () => {
                          _fileUploadController.pickFile(ImageSource.camera)
                        },
                        icon: const Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                        ),
                        width: width * 0.24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      AssessmentButton(
                        label: "Gallery",
                        onTap: () {
                          _fileUploadController.pickFile(ImageSource.gallery);
                        },
                        icon: const Icon(
                          Icons.upload_rounded,
                          color: Colors.white,
                        ),
                        width: width * 0.24,
                      ),
                      SizedBox(
                        width: width * 0.14,
                      ),
                      AssessmentButton(
                          label: "Upload",
                          onTap: _fileUploadController.uploadFileWithGeoTag,
                          icon: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          width: width * 0.24),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(top: 20, right: 20),
                       child: Obx(() {
                                 final uploadProgress = _fileUploadController.uploadProgress.value;
                                 if (uploadProgress < 1.0) {
                                   
                                   return CircularProgressIndicator(
                                     value: uploadProgress,
                                   );
                                 } else {
                                  
                                   return Text('Upload Complete');
                                 }
                               }),
                     ),
                   ],
                 ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Comments",
                    style: CustomTextTheme.questionTitleStyle,
                  ),
                ),
                const SizedBox(height: 18),
                AssessmentContainerWidget(
                    widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Enter text here', 
                        border: InputBorder.none,
                      )),
                )),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmitButton(
                      label: "Cancel",
                      onTap: () {},
                      userWidth: width * 0.36,
                    ),
                    SizedBox(width: width * 0.036),
                    SubmitButton(
                      label: "Next",
                      onTap: () async {
                        if (currentQuestionIndexFirebase <
                            data.questions.length - 1) {
                          currentQuestionIndexFirebase++;
                          Map<String, dynamic> dataToUpdate = {
                            'current question': currentQuestionIndexFirebase,
                          };
                          await docRef.update(dataToUpdate).then((_) {
                            print(
                                "Document successfully updated to $currentQuestionIndexFirebase");
                          });
                          _controller
                              .onNextQuestion(currentQuestionIndexFirebase);
                        } else if (currentQuestionIndexFirebase ==
                            data.questions.length - 1) {
                          Map<String, dynamic> isCompleted = {
                            'isCompleted': true,
                          };
                          await docRef.update(isCompleted);
                          
                          // TaskTile(await _fetchDocument());
                          Get.snackbar(
                              "Success", "Assessment Submitted Successfully");
                          Get.to(HomeScreen());
                        } else {
                          // TaskTile(await _fetchDocument());
                          Get.snackbar(
                              "Success", "Assessment Submitted Successfully");
                          Get.to(HomeScreen());
                        }

                        _scrollToTop();
                      },
                      userWidth: width * 0.48,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0, 
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut, 
    );
  }

  Future<Details?> _fetchDocument() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userIdConst)
          .collection('details')
          .doc(collegeFirebase)
          .get();

      if (documentSnapshot.exists) {
        Details details =
            Details.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        return details;
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
    return null;
  }
}
