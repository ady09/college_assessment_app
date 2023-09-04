import 'dart:io';

import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/header_container_widget.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/sub_header_container.dart';
import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/file_uploader_controller.dart';

class AssessmentScreen extends StatelessWidget {
  final AssessmentController controller = Get.put(AssessmentController());

  AssessmentScreen({
    super.key,
  });

  static final AssessmentController _assessmentController = AssessmentController();
  final FileUploadController _fileUploadController = Get.put(FileUploadController());
  final int currentQuestionIndex = _assessmentController.currentQuestionIndex.value +1 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            "Active Assessment",
            style: CustomTextTheme.HeadingStyle,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
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
                  questionNo: "QUESTION:  $currentQuestionIndex",
                  question: _assessmentController.currentQuestion.text),
                  ElevatedButton(
              onPressed: () => _fileUploadController.pickFile(ImageSource.camera),
              child: const Text('Pick a Photo/Video from Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _fileUploadController.pickFile(ImageSource.gallery),
              child: const Text('Pick a Photo/Video from Gallery'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return _fileUploadController.selectedFile.value != null
                  ? Image.file(File(_fileUploadController.selectedFile.value!.path))
                  : const Text('No file selected');
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fileUploadController.uploadFileWithGeoTag,
              child: const Text('Upload File'),
            ),
            ],

          ),
        ),
      ),
    );
  }

  
}


