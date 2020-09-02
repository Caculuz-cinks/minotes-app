import 'package:MiNotes/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget todoType(type, String image, BuildContext context) {
  Color backgroundColor;
  if (type == "Work")
    backgroundColor = AppColors.workColor.withOpacity(0.5);
  else if (type == "Finance")
    backgroundColor = AppColors.financeColor.withOpacity(0.5);
  else if (type == "Travel")
    backgroundColor = AppColors.travelColor.withOpacity(0.5);
  else if (type == "Study")
    backgroundColor = AppColors.studyColor.withOpacity(0.5);
  else if (type == "Personal")
    backgroundColor = AppColors.personalColor.withOpacity(0.5);
  else
    backgroundColor = AppColors.familyColor.withOpacity(0.5);
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/newnote", arguments: {
            "color": backgroundColor.toString(),
            "type": type,
            "isNew": true
          });
        },
        child: Container(
          width: 145.0,
          height: 160.0,
          // padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(image),
              SizedBox(
                height: 30,
              ),
              Text(
                type,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      )
    ],
  );
}
