import 'package:MiNotes/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:MiNotes/services/note.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:MiNotes/services/note_model.dart';

class AllNotes extends StatefulWidget {
  @override
  _AllNotesState createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  NoteModel noteInstance = NoteModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, '/'),
              child: SvgPicture.asset('assets/back.svg'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'All Notes',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: noteInstance.allNotes(context),
            ),
          ],
        ),
      ),
    );
  }
}
//
