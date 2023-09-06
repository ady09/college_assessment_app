import 'package:college_assessment_app/src/features/authentication/models/details.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final Details? details;

   TaskTile(this.details, {super.key, required this.widget});
  final Widget widget;

  
  @override
  Widget build(BuildContext context) {
    
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(details?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2, right: 10),
                      child: Icon(
                        Icons.school_sharp,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      details?.college ?? "",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.menu_book_sharp,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      details?.type ?? "",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1, right: 10),
                      child: Icon(
                        Icons.location_city_sharp,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      details?.city ?? "",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(quarterTurns: 3,
           child: widget
           
           
           
          //  Text(
          //     details!.isCompleted == true ? "COMPLETED" : "In Progress",
          //     style: GoogleFonts.lato(
          //       textStyle: const TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white),
          //     ),
          //   ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Color.fromARGB(255, 78, 91, 232);
      case 1:
        return const Color(0xFFffd1dc);
      case 2:
        return const Color(0xFF4e5ae8);
      default:
        return const Color(0xFFfaea05);
    }
  }
}
