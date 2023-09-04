import 'package:college_assessment_app/src/common_widgets/buttons/add_button.dart';
import 'package:college_assessment_app/src/common_widgets/list_animation/present_list.dart';
import 'package:college_assessment_app/src/features/authentication/models/details.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/assessment_screen.dart';
import 'package:college_assessment_app/src/features/authentication/screens/new_assessment/add_new_assessment.dart';
import 'package:college_assessment_app/src/utils/theme/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../controllers/fetch_data_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SubcollectionController _subcollectionController =
      Get.put(SubcollectionController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 24,
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
                    label: "+ New Assessment",
                    onTap: () => (Get.to(AddNewAssessment()))),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.064,
          ),
          _fetchDataList(),
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
            child: Text("Today", style: CustomTextTheme.HeadingStyle),
          ),
        ],
      ),
    );
  }

  _fetchDataList() {
    return Obx(() {
      if (_subcollectionController.subcollectionData.isEmpty) {
        return const Text('No data available.');
      } else {
        return _listData();
      }
    });
  }

  _listData() {
    return Expanded(
      child: ListView.builder(
        itemCount: _subcollectionController.subcollectionData.length,
        itemBuilder: (context, index) {
          // Map<String, dynamic> item =
          //     _subcollectionController.subcollectionData[index];
          return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(AssessmentScreen());
                      },
                      child: TaskTile(Details.fromJson(
                          _subcollectionController.subcollectionData[index])),
                    )
                  ],
                )),
              ));
        },
      ),
    );
  }
}

// Container(
//             width: 100,
//         height: 70,
//         color: Colors.green,
//         margin: const EdgeInsets.only(bottom: 10),
//             child: ListTile(
//               title: Text('city: ${item['city']}'),
//               subtitle: Text('college: ${item['college']}'),
//             ),
//           );