import 'package:MiNotes/services/note_model.dart';
import 'package:MiNotes/ui/colors/colors.dart';
import 'package:MiNotes/ui/size_config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget notesTile(SvgPicture image, NoteModel note, AlertDialog dialog,
    BuildContext context) {
  return Container(
    height: 84,
    decoration: BoxDecoration(
      color: AppColors.tileColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, left: 12),
                child: image,
              ),
              SizedBox(width: 20),
              Container(
                  width: Config.xMargin(context, 45),
                  child: Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(note.text,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 19.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ))
            ],
          ),
          Flexible(
            child: SizedBox(
              width: Config.xMargin(context, 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: PopupMenuButton(
                child: SvgPicture.asset('assets/options.svg'),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return dialog;
                              });
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ];
                }),
          ),
        ],
      ),
    ),
  );
}
