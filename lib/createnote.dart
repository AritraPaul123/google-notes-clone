import 'package:flutter/material.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/home.dart';
import 'package:googlenotes/services/db.dart';

import 'model/NoteModel.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController title=new TextEditingController();
  TextEditingController content=new TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white.withOpacity(0.8)),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              await NotesDatabse.instance.InsertEntry(Note(title: title.text ,content: content.text, pin : false,isArchived : false));
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
            },
            icon: Icon(Icons.save_outlined),
            splashRadius: 20,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                fontSize: 20,
                color: white,
                fontWeight: FontWeight.bold,
              ),
              controller: title,
              cursorColor: white,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle:
                  TextStyle(fontSize: 23, color: white.withOpacity(0.7))),
            ),
            Container(
              color: bgColor,
              height: 300,
              child: TextField(
                maxLines: null,
                minLines: 50,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 18, color: white),
                controller: content,
                cursorColor: white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle:
                    TextStyle(fontSize: 19, color: white.withOpacity(0.7))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
